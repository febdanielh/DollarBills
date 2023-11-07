//
//  MapView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .none)
                .ignoresSafeArea()
            
        }
}

#Preview {
    MapView()
}
