//
//  BeaconReceiverClass.swift
//  beacon
//
//  Created by William Kindlien Gunawan on 19/07/23.
//
import SwiftUI
import CoreLocation
import BackgroundTasks

class BeaconReceiver: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
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

    override init() {
        super.init()

        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self

        beacon1Region = CLBeaconRegion(proximityUUID: beacon1UUID, identifier: beacon1Identifier)
        beacon1Region.notifyEntryStateOnDisplay = true
        beacon1Region.notifyOnEntry = true
        beacon1Region.notifyOnExit = true

        beacon2Region = CLBeaconRegion(proximityUUID: beacon2UUID, identifier: beacon2Identifier)
        beacon2Region.notifyEntryStateOnDisplay = true
        beacon2Region.notifyOnEntry = true
        beacon2Region.notifyOnExit = true
    }

    func startReceivingBeacons() {
        locationManager.requestAlwaysAuthorization() // Request "Always" authorization for background execution

        // Add background execution mode to the location manager
        locationManager.allowsBackgroundLocationUpdates = true

        // Start monitoring and ranging for beacons
        locationManager.startMonitoring(for: beacon1Region)
        locationManager.startRangingBeacons(in: beacon1Region)

        locationManager.startMonitoring(for: beacon2Region)
        locationManager.startRangingBeacons(in: beacon2Region)

        scheduleBackgroundTask() // Schedule the background task
    }

    func stopReceivingBeacons() {
        locationManager.stopMonitoring(for: beacon1Region)
        locationManager.stopRangingBeacons(in: beacon1Region)

        locationManager.stopMonitoring(for: beacon2Region)
        locationManager.stopRangingBeacons(in: beacon2Region)

        sendDeleteRequest()
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

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let connected = !beacons.isEmpty
        let beaconIdentifier = region.identifier

        if beaconIdentifier == beacon1Identifier {
            if connected && !isConnectedToBeacon1 {
                beacon1Count += 1
                isConnectedToBeacon1 = true
            } else if !connected && isConnectedToBeacon1 {
                beacon1Count -= 1
                isConnectedToBeacon1 = false
            }
        } else if beaconIdentifier == beacon2Identifier {
            if connected && !isConnectedToBeacon2 {
                beacon2Count += 1
                isConnectedToBeacon2 = true
            } else if !connected && isConnectedToBeacon2 {
                beacon2Count -= 1
                isConnectedToBeacon2 = false
            }
        }
    }

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
    func fetchBeaconCounts() {
        guard let url = URL(string: "\(serverURL)/beaconCounts") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching beacon counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let beaconCounts = json as? [String: Int] {
                    DispatchQueue.main.async {
                        self.beacon1Count = beaconCounts[self.beacon1Identifier] ?? 0
                        self.beacon2Count = beaconCounts[self.beacon2Identifier] ?? 0
                    }
                }
            } catch {
                print("Error deserializing beacon counts: \(error)")
            }
        }

        task.resume()
    }

    // Background Task Handling

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

    func handleBackgroundTaskCompletionNotification() {
        BGTaskScheduler.shared.getPendingTaskRequests { (taskRequests) in
            guard let taskRequest = taskRequests.first(where: { $0.identifier == "com.example.beacon.backgroundTask" }) else {
                return
            }

            // Schedule the background task again if it's not yet completed
            if taskRequest.earliestBeginDate! > Date() {
                self.scheduleBackgroundTask()
            }
        }
    }

    // MARK: - CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // Start monitoring and ranging for beacons when the "Always" authorization is granted
            startReceivingBeacons()
        }
    }
}
