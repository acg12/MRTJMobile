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
    
    var body: some View {
        VStack(alignment: .leading, spacing: Cons.spacing) {
            HStack {
                CurrLocationTextView(station: locationManager.lastStation ?? "unknown")
                Spacer()
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.red)
                    Text("**LIVE**")
                        .font(.subheadline)
                }
            }
            
//            ScheduleCardView(line: scheduleVM.currStationObj?.firstLine)
            
            Spacer()
        }
        .padding(Cons.padding)
        .background(Color("backgroundGrey"))
        .onAppear {
            scheduleVM.setStation(station: locationManager.lastStation)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
