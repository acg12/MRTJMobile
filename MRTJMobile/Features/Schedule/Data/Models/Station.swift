//
//  Station.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import Foundation
import CoreLocation

struct Station {
    var name: String
    var firstLine: MRTLine
    var secondLine: MRTLine?
    var location: CLLocation
    var region: CLCircularRegion
    
    init(name: String, firstLine: MRTLine, secondLine: MRTLine? = nil, latitude: Double, longitude: Double) {
        self.name = name
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: CLLocationDistance(300), identifier: name)
    }
}
