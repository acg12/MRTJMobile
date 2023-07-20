//
//  Train.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import Foundation

struct Train {
    var density: [Int]
    private var arrival: Date
    
    init(density: [Int], arrival: Date) {
        self.density = density
        self.arrival = arrival
    }
    
    func getRemainingMinutes() -> Int {
        let now = Date.now
        let calendar = Calendar.current
        let remaining = calendar.dateComponents([.minute], from: now, to: arrival).minute!
        return remaining
    }
    
    func getArrivalTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:MM"
        return formatter.string(from: self.arrival) // 10:05
    }
}
