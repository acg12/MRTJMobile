//
//  StationData.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import Foundation
import CoreLocation

internal let stations: [String : Station] =
[
    "Lebak Bulus Grab" : Station(name: "Lebak Bulus Grab", firstLine: MRTLine(destination: "Bundaran HI", direction: .left, trains: [
            Train(density: [0, 1, 2, 3, 2, 1], arrival: Date(timeIntervalSinceNow: 300)),
            Train(density: [5, 5, 5, 5, 5, 5], arrival: Date(timeIntervalSinceNow: 600))
        ]), latitude: -6.226963, longitude: 106.591275)
]
