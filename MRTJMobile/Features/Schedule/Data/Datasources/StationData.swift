//
//  StationData.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import Foundation
import CoreLocation

//struct stationLists {
//    static let lists: [Station] = [
//        Station(name: "Lebak Bulus Grab", latitude: -6.289361581369295, longitude:  106.77411877729375),
//        Station(name: "Fatmawati", latitude: -6.29233267870528, longitude: 106.79289988304943),
//        Station(name: "Cipete Raya", latitude: -6.278104616151923, longitude: 106.79798718927083),
//        Station(name: "Haji Nawi", latitude: -6.266510647480234, longitude: 106.7980622625107),
//        Station(name: "Blok A", latitude: -6.255571978823519, longitude: 106.79788572020587),
//        Station(name: "Blok M BCA", latitude: -6.244331332649756, longitude: 106.79930163398298),
//        Station(name: "Asean", latitude: -6.23820139712473, longitude: 106.79884060919622),
//        Station(name: "Senayan", latitude: -6.226537939407252, longitude: 106.80296019807083),
//        Station(name: "Istora Mandiri", latitude: -6.222137304489382, longitude: 106.80938263548595),
//        Station(name: "Bendungan Hilir", latitude: -6.214871994696852, longitude:  106.81856154505303),
//        Station(name: "Setiabudi Astra", latitude: -6.208682460042654, longitude: 106.82264328920336),
//        Station(name: "Dukuh Atas BNI", latitude: -6.200658526399624, longitude:  106.82320379630734),
//        Station(name: "Bundaran HI", latitude: -6.1916572930385225, longitude: 106.8235240289828)
//    ]
//}

internal var trains = [
    Train(id: 1, density: [4, 1, 2, 3, 2, 1]),
    Train(id: 2, density: [5, 5, 3, 2, 1, 2]),
    Train(id: 3, density: [1, 2, 1, 4, 2, 1]),
    Train(id: 4, density: [1, 2, 2, 2, 3, 1]),
    Train(id: 5, density: [1, 4, 4, 4, 2, 1]),
    Train(id: 6, density: [1, 1, 2, 5, 2, 1]),
]

internal var stationNames = ["Lebak Bulus Grab", "Fatmawati", "Cipete Raya"]

internal var stations = [
    "Lebak Bulus Grab" : Station(name: "Lebak Bulus Grab", firstLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
        TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
        TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
    ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
        TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
        TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
    ]), latitude: -6.289361581369295, longitude: 106.77411877729375),
    "Fatmawati" : Station(name: "Fatmawati", firstLine: MRTLine(destination: "Lebak Bulus Grab", direction: .left, trains: [
        TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
        TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
    ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
        TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
        TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
    ]), latitude: -6.29233267870528, longitude: 106.79289988304943),
    "Cipete Raya" : Station(name: "Cipete Raya", firstLine: MRTLine(destination: "Lebak Bulus Grab", direction: .left, trains: [
        TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
        TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
    ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
        TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
        TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
        TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
    ]), latitude: -6.278104616151923, longitude: 106.79798718927083),
]

//class StationData: ObservableObject {
//    @Published var stations: [String : Station]
//
//    init() {
//        self.stations = [
//            "Lebak Bulus Grab" : Station(name: "Lebak Bulus Grab", firstLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
//                TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
//                TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
//            ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
//                TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
//                TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
//            ]), latitude: -6.289361581369295, longitude: 106.77411877729375),
//            "Fatmawati" : Station(name: "Fatmawati", firstLine: MRTLine(destination: "Lebak Bulus Grab", direction: .left, trains: [
//                TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
//                TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
//            ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
//                TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
//                TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
//            ]), latitude: -6.29233267870528, longitude: 106.79289988304943),
//            "Cipete Raya" : Station(name: "Cipete Raya", firstLine: MRTLine(destination: "Lebak Bulus Grab", direction: .left, trains: [
//                TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
//                TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
//            ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
//                TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
//                TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
//                TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
//            ]), latitude: -6.278104616151923, longitude: 106.79798718927083),
//        ]
//    }
//}
