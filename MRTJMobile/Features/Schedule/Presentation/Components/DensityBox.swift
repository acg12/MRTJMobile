//
//  DensityBox.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 20/07/23.
//

import SwiftUI

struct DensityBox: View {
    var density: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor((density <= 4) ? ((density <= 2) ? Color("boxGreen") : Color("boxOrange")) : Color("boxRed"))
                .frame(width: Cons.densityBoxWidth, height: Cons.densityBoxHeight)
            Image(systemName: "figure.stand")
                .frame(height: Cons.densityBoxHeight - 10)
                .foregroundColor(.white)
        }
    }
}

struct DensityBox_Previews: PreviewProvider {
    static var previews: some View {
        DensityBox(density: 5)
    }
}
