//
//  ReceiverTemp.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI
struct ReceiverView: View {
    @StateObject private var beaconReceiver = BeaconReceiver()

    @State private var selectedTab = 0
        
    
    var body: some View {
        VStack {
            Text("Beacon 1 Count: \(beaconReceiver.beacon1Count)")
            Text("Beacon 2 Count: \(beaconReceiver.beacon2Count)")
//            TabBarView(selectedTab: $selectedTab)
        }
        .onAppear {
            beaconReceiver.startReceivingBeacons()
            beaconReceiver.fetchBeaconCounts() // Fetch beacon counts when the view appears
        }
        .onDisappear {
//            beaconReceiver.stopReceivingBeacons()
        }
    }
}
