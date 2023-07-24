//
//  ContentView.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    @State private var selectedTab = 0
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Image("Header")
//                .frame(height: 30)
           
            TabBarView(selectedTab: $selectedTab)
                .environmentObject(locationManager)
        }
        .onAppear {
            locationManager.startReceivingBeacons()
        }
        .background(Color("backgroundGrey"))
        .ignoresSafeArea()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager.shared)
    }
}
