//
//  ScheduleView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 18/07/23.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var scheduleVM = ScheduleViewModel()
    @State var station: Station? = stations["Lebak Bulus Grab"]
    
    @State private var available = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Cons.spacing) {
                HStack {
                    CurrLocationTextView(stationName: station?.name ?? "unknown", station: $station)
                    Spacer()
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.red)
                        Text("**LIVE**")
                            .font(.subheadline)
                    }
                }
                
                if let st = self.station {
                    ScheduleCardView(line: st.firstLine, num: 1)

                    if let secondLine = st.secondLine {
                        ScheduleCardView(line: secondLine, num: 2)
                    }
                }
                
                Spacer()
            }
            .padding(Cons.padding)
        }
        .onAppear {
            station = locationManager.lastStation
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(LocationManager.shared)
    }
}
