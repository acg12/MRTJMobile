//
//  ScheduleCardView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

struct ScheduleCardView: View {
    var line: MRTLine
    var num: Int
    @State var showNextTrains: Bool = false
    
    var body: some View {
        VStack(spacing: Cons.largeSpacing) {
            HStack(alignment: .center, spacing: Cons.spacing) {
                Image("Line Number-\(num)")
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
                        ForEach(line.trains[0].train.density, id: \.self) { density in
                            DensityBox(density: density)
                        }
                    }
                    .offset(x: Cons.densityBoxPadding, y: Cons.densityBoxPadding)
                }
            } else {
                ZStack(alignment: .topTrailing) {
                    Image("Train-right")
                        .scaledToFit()
                    HStack(spacing: 4) {
                        ForEach(line.trains[0].train.density, id: \.self) { density in
                            DensityBox(density: density)
                        }
                    }
                    .offset(x: -Cons.densityBoxPadding, y: Cons.densityBoxPadding)
                }
            }
            
            // MARK: next train details
            HStack(alignment: .top) {
                Image(systemName: "clock")
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Next Train")
                            .font(.subheadline)
                        Button {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                showNextTrains.toggle()
                            }
                        } label: {
                            HStack {
                                Image(systemName: (showNextTrains ? "chevron.up" : "chevron.down"))
                                Spacer()
                            }
                            .foregroundColor(.black)
                        }
                    }
                    
                    VStack {
                        if line.trains.count > 1 {
                            HStack(spacing: 2) {
                                ForEach(line.trains[1].train.density, id: \.self) { density in
                                    RoundedRectangle(cornerRadius: 1)
                                        .foregroundColor((density <= 4) ? ((density <= 2) ? Color("boxGreen") : Color("boxOrange")) : Color("boxRed"))
                                        .frame(width: Cons.compDensBoxWidth, height: Cons.compDensBoxHeight)
                                }
                                Spacer()
                                Text("\(line.trains[1].getRemainingMinutes())")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text("mins")
                                    .font(.caption)
                            }
                        }
                        
                        if line.trains.count > 2 {
                            Divider()
                                .padding([.top, .bottom])
                            HStack(spacing: 2) {
                                ForEach(line.trains[2].train.density, id: \.self) { density in
                                    RoundedRectangle(cornerRadius: 1)
                                        .foregroundColor((density <= 4) ? ((density <= 2) ? Color("boxGreen") : Color("boxOrange")) : Color("boxRed"))
                                        .frame(width: Cons.compDensBoxWidth, height: Cons.compDensBoxHeight)
                                }
                                Spacer()
                                Text("\(line.trains[2].getRemainingMinutes())")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text("mins")
                                    .font(.caption)
                            }
                        }
                    }
                    .opacity(showNextTrains ? 1 : 0)
                    .frame(height: (showNextTrains ? nil : 0))
                }
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
            TrainTime(train: trains[0], arrival: Date(timeIntervalSinceNow: 300)),
            TrainTime(train: trains[1], arrival: Date(timeIntervalSinceNow: 600)),
            TrainTime(train: trains[2], arrival: Date(timeIntervalSinceNow: 900)),
        ]), num: 1)
    }
}
