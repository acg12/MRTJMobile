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
         
               
            HStack{
                VStack{
                    Text("You're now at :")
                        
                 
                    Text("BLOK M BCA")
                        .font(.title)
              
                }
                Spacer()
            }
            Text("Bunderan HI:               \(randomNumber1) minutes")
                .padding()
            Text("Lebak Bukus:                 \(randomNumber2) minutes")
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

struct RandomNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
