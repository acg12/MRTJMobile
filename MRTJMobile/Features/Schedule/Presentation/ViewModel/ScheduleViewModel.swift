//
//  ScheduleViewModel.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 19/07/23.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    var currStationObj: Station?
    var numLines: Int = 1
    
    func setStation(station: String?) {
        guard let station = station else { return }
        
        if let s = stations[station] {
            currStationObj = s as Station
            numLines = (s.secondLine == nil) ? 1 : 2
        }
    }
}
