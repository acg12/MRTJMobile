//
//  MRTJMobileApp.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI
import PartialSheet
@main
struct MRTJMobileApp: App {
    @StateObject private var partialSheetManager = PartialSheetManager()
    @StateObject private var locationManager = LocationManager.shared

      var body: some Scene {
          WindowGroup {
              ContentView()
                  // Set the environment object for PartialSheetManager
                  .environmentObject(partialSheetManager)
                  .environmentObject(locationManager)
             .preferredColorScheme(.light)
          }
      }
  }


