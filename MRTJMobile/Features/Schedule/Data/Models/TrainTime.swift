//
//  TrainTime.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 21/07/23.
//

import Foundation

struct TrainTime {
    var train: Train
    private var arrival: Date
    
    init(train: Train, arrival: Date) {
        self.train = train
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
