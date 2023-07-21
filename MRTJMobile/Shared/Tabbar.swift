//
//  Tabbar.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI
struct TabBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                
                TabView(selection: $selectedTab) {
                    ForEach(0..<tabItems.count) { index in
                        tabItems[index].view
                          
                            .tabItem {
                                
                                Image(systemName: tabItems[index].iconName)
                                
                                Text(tabItems[index].title)
                            }
                            .tag(index)
                            .id(index)
                        
                    }
                }
                .accentColor(.blue)
                
                Spacer()
                
         
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}


struct TabBarItem {
    let iconName: String
    let title: String
    let view: AnyView
}

let tabItems: [TabBarItem] = [
    TabBarItem(iconName: "house", title: "Home", view:
                AnyView(homeView())),
//    tinggal ganti ke "AnyView(ContentView()))," sebagai contoh untuk masuk ke view masing-masing
    TabBarItem(iconName: "clock", title: "Schedule", view: AnyView(ScheduleView())),
    TabBarItem(iconName: "map", title: "Map", view: AnyView(MapView()))
]

