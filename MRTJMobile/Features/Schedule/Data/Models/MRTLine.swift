//
//  MRTLine.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import Foundation

enum ArrDirection {
    case left, right
}

struct MRTLine {
    var destination: String
    var direction: ArrDirection
    var trains: [TrainTime]
}
