//
//  CurrLocationTextView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 19/07/23.
//

import SwiftUI

struct CurrLocationTextView: View {
    @State var stationName: String
    @Binding var station: Station?
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
            Text("You are now at")
                .font(.subheadline)
            Picker("Choose a station", selection: $stationName) {
                ForEach(stationNames, id: \.self) {
                    Text($0)
                }
            }
            .onChange(of: stationName) { newValue in
                station = stations[newValue]
            }
        }
    }
}

struct CurrLocationTextView_Previews: PreviewProvider {
    static var previews: some View {
        CurrLocationTextView(stationName: "Lebak Bulus Grab", station: .constant(Station(name: "Lebak Bulus Grab", firstLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
            TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
            TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
            TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
        ]), secondLine: MRTLine(destination: "Bundaran HI", direction: .right, trains: [
            TrainTime(train: trains[3], arrival: Date(timeIntervalSinceNow: 300)),
            TrainTime(train: trains[4], arrival: Date(timeIntervalSinceNow: 700)),
            TrainTime(train: trains[5], arrival: Date(timeIntervalSinceNow: 800)),
        ]), latitude: -6.289361581369295, longitude: 106.77411877729375)))
    }
}
