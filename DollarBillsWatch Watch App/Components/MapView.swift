//
//  MapView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .ignoresSafeArea()
            .accentColor(.blue)
            .onAppear {
                locationManager.checkServiceAvailability()
            }
    }
}

#Preview {
    MapView()
}
