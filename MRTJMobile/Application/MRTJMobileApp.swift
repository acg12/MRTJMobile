//
//  MRTJMobileApp.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

@main
struct MRTJMobileApp: App {
    var body: some Scene {
        WindowGroup {
            ScheduleView()
                .preferredColorScheme(.light)
        }
    }
}
