//
//  ScheduleView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 18/07/23.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var scheduleVM = ScheduleViewModel()
    
    @State private var available = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Cons.spacing) {
            HStack {
                CurrLocationTextView(station: locationManager.lastStation?.name ?? "unknown")
                Spacer()
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.red)
                    Text("**LIVE**")
                        .font(.subheadline)
                }
            }
            
            if let station = locationManager.lastStation {
                ScheduleCardView(line: station.firstLine, num: 1)

                if let secondLine = station.secondLine {
                    ScheduleCardView(line: secondLine, num: 2)
                }
            }
            
            Spacer()
        }
        .padding(Cons.padding)
        .background(Color("backgroundGrey"))
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
