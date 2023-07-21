//
//  DensityBox.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

struct DensityBox: View {
    var density: Int
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor((density <= 4) ? ((density <= 2) ? Color("boxGreen") : Color("boxOrange")) : Color("boxRed"))
                .frame(width: width, height: height)
            Image(systemName: "figure.stand")
                .frame(height: height - 10)
                .foregroundColor(.white)
        }
    }
}

struct DensityBox_Previews: PreviewProvider {
    static var previews: some View {
        DensityBox(density: 5, height: CGFloat(50), width: CGFloat(50))
    }
}
