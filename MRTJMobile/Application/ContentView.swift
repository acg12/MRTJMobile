//
//  ContentView.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack{
            Image("Header")
                .ignoresSafeArea()
                .frame(height: 30)
           
            TabBarView(selectedTab: $selectedTab)
//                .padding(.bottom, 0)
////                .shadow(radius: 1)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

