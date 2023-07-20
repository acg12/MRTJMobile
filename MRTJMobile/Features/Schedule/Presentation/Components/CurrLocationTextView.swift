//
//  CurrLocationTextView.swift
//  CrowdControlMRTJ
//
//  Created by Angela Christabel on 19/07/23.
//

import SwiftUI

struct CurrLocationTextView: View {
    var station: String
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
            Text("You are now at **\(station)**")
                .font(.subheadline)
        }
    }
}

struct CurrLocationTextView_Previews: PreviewProvider {
    static var previews: some View {
        CurrLocationTextView(station: "Blok M BCA")
    }
}
