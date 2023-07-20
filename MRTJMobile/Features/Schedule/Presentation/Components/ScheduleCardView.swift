//
//  ScheduleCardView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

struct ScheduleCardView: View {
    var line: MRTLine
    
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
            
            ZStack {
                Image("Train-left")
                    .scaledToFill()
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
            Train(density: [0, 1, 2, 3, 2, 1], arrival: Date(timeIntervalSinceNow: 300)),
            Train(density: [5, 5, 5, 5, 5, 5], arrival: Date(timeIntervalSinceNow: 600))
        ]))
    }
}
