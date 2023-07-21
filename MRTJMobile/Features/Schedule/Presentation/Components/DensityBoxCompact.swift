//
//  DensityBoxCompact.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 21/07/23.
//

import SwiftUI

struct DensityBoxCompact: View {
    var density: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor((density <= 4) ? ((density <= 2) ? Color("boxGreen") : Color("boxOrange")) : Color("boxRed"))
            .frame(width: Cons.compDensBoxWidth, height: Cons.compDensBoxHeight)
    }
}

struct DensityBoxCompact_Previews: PreviewProvider {
    static var previews: some View {
        DensityBoxCompact(density: 3)
    }
}
