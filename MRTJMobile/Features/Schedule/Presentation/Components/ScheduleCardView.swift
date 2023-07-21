//
//  ScheduleCardView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

struct ScheduleCardView: View {
    var line: MRTLine
    @State var showNextTrains: Bool = false
    
    var body: some View {
        VStack(spacing: Cons.largeSpacing) {
            HStack(alignment: .center, spacing: Cons.spacing) {
                Image("Line Number-1")
                VStack(alignment: .leading) {
                    Text(line.destination)
                        .font(.title2)
                        .fontWeight(.medium)
                    Text(line.trains[0].getArrivalTime())
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    Text("\(line.trains[0].getRemainingMinutes())")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("mins")
                        .font(.subheadline)
                }
            }
            
            if line.direction == .left {
                ZStack(alignment: .topLeading) {
                    Image("Train-left")
                        .scaledToFit()
                    HStack(spacing: 4) {
                        ForEach(line.trains[0].density, id: \.self) { density in
                            DensityBox(density: density, height: Cons.densityBoxHeight, width: Cons.densityBoxWidth)
                        }
                    }
                    .offset(x: Cons.densityBoxPadding, y: Cons.densityBoxPadding)
                }
            } else {
                ZStack(alignment: .topTrailing) {
                    Image("Train-right")
                        .scaledToFit()
                    HStack(spacing: 4) {
                        ForEach(line.trains[0].density, id: \.self) { density in
                            DensityBox(density: density, height: Cons.densityBoxHeight, width: Cons.densityBoxWidth)
                        }
                    }
                    .offset(x: -Cons.densityBoxPadding, y: Cons.densityBoxPadding)
                }
            }
            
            // MARK: show next trains
            
            
            // MARK: next train details
            VStack {
                Button {
                    showNextTrains.toggle()
                } label: {
                    HStack {
                        Image(systemName: "clock")
                        Text("Next Train")
                            .font(.subheadline)
                        Image(systemName: (showNextTrains ? "chevron.up" : "chevron.down"))
                        Spacer()
                    }
                    .foregroundColor(.black)
                }
                
                VStack {
                    HStack {
                        if line.trains.count > 1 {
                            HStack(spacing: 4) {
                                ForEach(line.trains[1].density, id: \.self) { density in
                                    DensityBox(density: density, height: Cons.densityBoxHeight, width: Cons.densityBoxWidth)
                                }
                            }
                        }
                        
                        if line.trains.count > 2 {
                            HStack(spacing: 4) {
                                ForEach(line.trains[2].density, id: \.self) { density in
                                    DensityBox(density: density, height: Cons.densityBoxHeight, width: Cons.densityBoxWidth)
                                }
                            }
                        }
                        
                        Spacer()
                        
//                        Text("\()")
                    }
                }
                .opacity(showNextTrains ? 1 : 0)
                .frame(height: (showNextTrains ? nil : 0))
            }
        }
        .padding(Cons.spacing)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: Cons.borderRadius))
    }
}

struct ScheduleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCardView(line: MRTLine(destination: "Bundaran HI", direction: .left, trains: [
            Train(density: [2, 2, 4, 5, 4, 1], arrival: Date(timeIntervalSinceNow: 300)),
            Train(density: [5, 5, 5, 5, 5, 5], arrival: Date(timeIntervalSinceNow: 600))
        ]))
    }
}
