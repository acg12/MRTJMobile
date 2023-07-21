//
//  Sheet.swift
//  MRTJMobile
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI

struct RandomNumberView: View {
    @State private var randomNumber1 = 0
    @State private var randomNumber2 = 0

    var body: some View {
        VStack {
            HStack {
                Image("tren")
                    
                   
                VStack(alignment: .leading) {
                
                    Text("You're now at :")
                        
                    Text("BLOK M BCA")
                        .font(.title)
                }
                .padding()
                Spacer()
            }
            .padding(.horizontal)

            HStack {
                Image(systemName: "arrow.right") // Add the arrow symbol here
                    .foregroundColor(.black)
                    .padding(.trailing)
                Text("Bunderan HI:")
                Spacer()
                Text("\(randomNumber1) minutes")
            }
            .padding()

            HStack {
                Image(systemName: "arrow.right") // Add the arrow symbol here
                    .foregroundColor(.black)
                    .padding(.trailing)
                Text("Lebak Bulus:")
                Spacer()
                Text("\(randomNumber2) minutes")
            }
            .padding()

            Spacer()
        }
        .onAppear {
            generateRandomNumbers()
        }
    }

    private func generateRandomNumbers() {
        randomNumber1 = Int.random(in: 1...30)
        randomNumber2 = Int.random(in: 1...30)
    }
}


