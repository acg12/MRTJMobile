//
//  Mapview.swift
//  beacon
//
//  Created by William Kindlien Gunawan on 20/07/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -6.239085, longitude: 106.7985954),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var selectedPinIndex: Int? = nil
   
    @State private var showRandomSheet = false
    var coordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: -6.2894, longitude: 106.7740),
       
        CLLocationCoordinate2D(latitude: -6.2925, longitude: 106.7925),
        CLLocationCoordinate2D(latitude: -6.2774, longitude: 106.7975),
        CLLocationCoordinate2D(latitude: -6.2667, longitude: 106.7973),
        CLLocationCoordinate2D(latitude: -6.2561, longitude: 106.7972),
        CLLocationCoordinate2D(latitude: -6.2445, longitude: 106.7981),
        CLLocationCoordinate2D(latitude: -6.239085, longitude: 106.7985954),
        CLLocationCoordinate2D(latitude: -6.2267, longitude: 106.8025),
        CLLocationCoordinate2D(latitude: -6.2227654895, longitude: 106.808411655),
        CLLocationCoordinate2D(latitude: -6.2154465, longitude: 106.8173187),
        CLLocationCoordinate2D(latitude: -6.2091, longitude: 106.8217),
        CLLocationCoordinate2D(latitude: -6.2008, longitude: 106.8228),
        CLLocationCoordinate2D(latitude: -6.1934095, longitude: 106.8228579)
    ]
    var labels: [String] = [
                  "Lebak Bulus",
                  "Fatmawati",
                  "Cipete Raya",
                  "Haji Nawi",
                  "Blok A",
                  "Blok M",
                  "ASEAN",
                  "Senayan",
                  "Istora",
                  "Benhil",
                  "Setiabudi",
                  "Dukuh Atas",
                  "Bundaran HI"
              ]
    
    var body: some View {
        ZStack {
                   Color.white // Set the background color to white or any other color you prefer
                   
                   Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all, showsUserLocation: true)
                .gesture(MagnificationGesture()
                                          .onChanged { scale in
                                              zoom(scale)
                                          }
                              )
                       .frame(maxWidth: .infinity, maxHeight: .infinity)

                   MapViewWithPin(coordinates: coordinates, labels: labels, region: $region)
            
              
                   VStack {
                       Spacer()
                       HStack {
                           Spacer()
                           Button(action: {
                               zoomIn()
                           }) {
                               Image(systemName: "plus")
                                   .padding()
                                   .background(Color.white)
                                   .clipShape(Circle())
                                   .shadow(radius: 5)
                           }
                           .padding(.trailing, 20)
                           
                           Button(action: {
                               zoomOut()
                           }) {
                               Image(systemName: "minus")
                                   .padding()
                                   .background(Color.white)
                                   .clipShape(Circle())
                                   .shadow(radius: 5)
                           }
                           .padding(.leading, 20)
                       }
                       .padding(.bottom, 40)
                   }
               }
           }
           
           private func zoomIn() {
               var span = region.span
               span.latitudeDelta = max(span.latitudeDelta / 2, 0.01)
               span.longitudeDelta = max(span.longitudeDelta / 2, 0.01)
               region.span = span
           }
           
           private func zoomOut() {
               var span = region.span
               span.latitudeDelta = min(span.latitudeDelta * 2, 180)
               span.longitudeDelta = min(span.longitudeDelta * 2, 180)
               region.span = span
           }
    private func zoom(_ scale: CGFloat) {
            var span = region.span
            span.latitudeDelta = max(min(span.latitudeDelta / scale, 180), 0.01)
            span.longitudeDelta = max(min(span.longitudeDelta / scale, 180), 0.01)
            region.span = span
        }
}





struct MapViewWithPin: UIViewRepresentable {
    var coordinates: [CLLocationCoordinate2D]
    var labels: [String] // Add the labels array
    @Binding var region: MKCoordinateRegion
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator // Assign the coordinator as the delegate
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        view.removeOverlays(view.overlays)

        // Make sure coordinates and labels have the same number of elements
        guard coordinates.count == labels.count else {
            fatalError("The number of coordinates and labels must be the same.")
        }

        for (index, coordinate) in coordinates.enumerated() {
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = labels[index] // Set the title to the corresponding label
            view.addAnnotation(pin)
        }

        if coordinates.count >= 2 {
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            view.addOverlay(polyline)

            var minLat: CLLocationDegrees = 90
            var maxLat: CLLocationDegrees = -90
            var minLon: CLLocationDegrees = 180
            var maxLon: CLLocationDegrees = -180

            for coordinate in coordinates {
                minLat = min(minLat, coordinate.latitude)
                maxLat = max(maxLat, coordinate.latitude)
                minLon = min(minLon, coordinate.longitude)
                maxLon = max(maxLon, coordinate.longitude)
            }

            let span = region.span
            let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) / 2, longitude: (maxLon + minLon) / 2)
            let region = MKCoordinateRegion(center: center, span: span)
            view.setRegion(region, animated: true)
        }
    }

    // Coordinator to handle MKMapViewDelegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewWithPin

        init(_ parent: MapViewWithPin) {
            self.parent = parent
        }

        // Implement rendererFor method to draw the polyline
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}




struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
