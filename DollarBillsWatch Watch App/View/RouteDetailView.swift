//
//  RouteDetailView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct RouteDetailView: View {
    @StateObject private var locationManager = LocationManager()
    var route: Routes
    var body: some View {
        
        ScrollView {
            VStack{
                MapView()
                    .frame(height: 170)
                RouteSheet(routes: route)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RouteDetailView(route: Routes(tag: 3, routeName: "Green Office Park", routeNameDetail: "BSD, Tangerang", routeImage: "green office park", routeCount: 3, latitude: -6.301616, longitude: 106.651096))
}
