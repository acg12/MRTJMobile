//
//  LocationManager.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 19/07/23.
//

import Foundation
import CoreLocation
import Combine
import BackgroundTasks
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var lastStation: Station?
    
    // TrainData dibuat array aja ? Station dibuat class ? atau kebalikannya :)
//    private var stations = StationData().stations
    
    private let beacon1UUID = UUID(uuidString: "46DFC726-44FF-43E7-8694-67457A1B9C83")!
    private let beacon2UUID = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")! // Random UUID for Beacon 2

    // Update the server URL with your server's IP address or domain name
    private let serverURL = "http://192.168.0.191:3000"
    // pake "ifconfig | grep "inet " | grep -v 127.0.0.1" to find out ipadress
    
    private let beacon1Identifier = "Beacon1"
    private let beacon2Identifier = "Beacon2" // Identifier for Beacon 2

    private var beacon1Region: CLBeaconRegion!
    private var beacon2Region: CLBeaconRegion!

    private var isConnectedToBeacon1 = false
    private var isConnectedToBeacon2 = false
    
    @Published var beacon1Count = 0 {
        didSet {
            sendBeaconData(beacon1Count, beaconIdentifier: beacon1Identifier)
        }
    }

    @Published var beacon2Count = 0 {
        didSet {
            sendBeaconData(beacon2Count, beaconIdentifier: beacon2Identifier)
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        beacon1Region = CLBeaconRegion(uuid: beacon1UUID, identifier: beacon1Identifier)
        beacon1Region.notifyEntryStateOnDisplay = true
        beacon1Region.notifyOnEntry = true
        beacon1Region.notifyOnExit = true
        
        beacon2Region = CLBeaconRegion(uuid: beacon2UUID, identifier: beacon2Identifier)
        beacon2Region.notifyEntryStateOnDisplay = true
        beacon2Region.notifyOnEntry = true
        beacon2Region.notifyOnExit = true
    }
    
    // MARK: Monitoring Beacons
    func startReceivingBeacons() {
        // Add background execution mode to the location manager
        locationManager.allowsBackgroundLocationUpdates = true

        // Start monitoring and ranging for beacons
        locationManager.startMonitoring(for: beacon1Region)
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon1UUID))

        locationManager.startMonitoring(for: beacon2Region)
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon2UUID))

        scheduleBackgroundTask() // Schedule the background task
    }
    
    func stopReceivingBeacons() {
        locationManager.stopMonitoring(for: beacon1Region)
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon1UUID))

        locationManager.stopMonitoring(for: beacon2Region)
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon2UUID))

        sendDeleteRequest()
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard beacons != [] else {return}
        
        let beacon = beacons.first!
        let connected = !beacons.isEmpty
        let beaconIdentifier = region.identifier

        if beaconIdentifier == beacon1Identifier {
            if connected && !isConnectedToBeacon1 {
                beacon1Count += 1
                isConnectedToBeacon1 = true
                addPassenger(beacon)
            } else if !connected && isConnectedToBeacon1 {
                beacon1Count -= 1
                isConnectedToBeacon1 = false
            }
        } else if beaconIdentifier == beacon2Identifier {
            if connected && !isConnectedToBeacon2 {
                beacon2Count += 1
                isConnectedToBeacon2 = true
                addPassenger(beacon)
            } else if !connected && isConnectedToBeacon2 {
                beacon2Count -= 1
                isConnectedToBeacon2 = false
            }
        }
    }
    
    func addPassenger(_ beacon: CLBeacon) {
        let trainId = Int(truncating: beacon.major)
        let cartId = Int(truncating: beacon.minor)
        print("added passenger to train: \(trainId) - cart: \(cartId)")
        trains[trainId - 1].density[cartId - 1] += 1
    }
    
    func removePassenger(_ beacon: CLBeacon) {
        let trainId = Int(truncating: beacon.major)
        let cartId = Int(truncating: beacon.minor)
        
        if trains[trainId - 1].density[cartId - 1] > 0 {
            trains[trainId - 1].density[cartId - 1] -= 1
        }
    }
    
    // MARK: Background tasks
    func scheduleBackgroundTask() {
        let identifier = "com.example.beacon.backgroundTask"
        let taskRequest = BGProcessingTaskRequest(identifier: identifier)
        taskRequest.requiresNetworkConnectivity = true // Specify if the task requires network connectivity
        taskRequest.requiresExternalPower = false // Specify if the task requires external power source

        do {
            try BGTaskScheduler.shared.submit(taskRequest)
        } catch {
            print("Failed to submit background task: \(error)")
        }
    }
    
    // MARK: Network functions
    func sendDeleteRequest() {
        guard let deviceId = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }

        let urlString = "\(serverURL)/beacon/\(deviceId)"

        guard let url = URL(string: urlString) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error sending delete request: \(error)")
            }
        }

        task.resume()
    }

    func sendBeaconData(_ value: Int, beaconIdentifier: String) {
        guard let url = URL(string: "\(serverURL)/beacon") else {
            return
        }

        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let data = ["deviceId": deviceId, "value": value, "beaconIdentifier": beaconIdentifier] as [String: Any]

        print("Sending beacon data: \(data)")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error sending beacon data: \(error)")
                    return
                }

                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Received response from server: \(json)")

                        if let jsonDict = json as? [String: Any], let beaconCounts = jsonDict["beaconCounts"] as? [String: Int] {
                            DispatchQueue.main.async {
                                if let count = beaconCounts[self.beacon1Identifier] {
                                    self.beacon1Count = count
                                }
                                if let count = beaconCounts[self.beacon2Identifier] {
                                    self.beacon2Count = count
                                }
                            }
                        }
                    } catch {
                        print("Error deserializing beacon data: \(error)")
                    }
                }
            }

            task.resume()
        } catch {
            print("Error serializing beacon data: \(error)")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            for station in stations {
                locationManager.startMonitoring(for: station.value.region)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if region is CLBeaconRegion {
            switch state {
            case .inside:
                print("inside beacon \(region)")
            case .outside:
                print("outside beacon \(region)")
            case .unknown:
                print("unknown beacon")
            }
        } else {
            switch state {
            case .inside:
                lastStation = stations[region.identifier]
                print("inside \(region)")
            case .outside:
                print("outside \(region)")
            case .unknown:
                print("unknown")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLBeaconRegion {
            locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
        }
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLBeaconRegion {
            let beaconIdentifier = (region as! CLBeaconRegion).identifier
            if beaconIdentifier == beacon1Identifier && isConnectedToBeacon1 {
                beacon1Count -= 1
                isConnectedToBeacon1 = false
            } else if beaconIdentifier == beacon2Identifier && isConnectedToBeacon2 {
                beacon2Count -= 1
                isConnectedToBeacon2 = false
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
