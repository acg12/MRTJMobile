//
//  Tabbar.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI
struct TabBarView: View {
    @Binding var selectedTab: Int
    @EnvironmentObject private var locationManager: LocationManager
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().backgroundColor = UIColor(Color.white)
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(1)
                    .background(Color("backgroundGrey"))
                
                ScheduleView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Schedule")
                    }
                    .tag(2)
                    .environmentObject(locationManager)
                    .background(Color("backgroundGrey"))
                
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(3)
                    .environmentObject(locationManager)
                    .background(Color("backgroundGrey"))
            }
            .accentColor(.blue)
            .navigationBarHidden(true)
        }
    }
}
