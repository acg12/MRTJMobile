//
//  StationSheetView.swift
//  MRTJMobile
//
//  Created by Angela Christabel on 24/07/23.
//

import SwiftUI

struct StationSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedStation: String
    
    var body: some View {
        Picker("Choose a station", selection: $selectedStation) {
            ForEach(Array(stations.keys), id: \.self) {
                Text($0)
            }
        }
    }
}

struct StationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StationSheetView(selectedStation: .constant("Blok M BCA"))
    }
}
