//
//  Routes.swift
//  DollarBills
//
//  Created by Febrian Daniel on 19/10/23.
//

import Foundation
import MapKit

struct Routes: Identifiable, Hashable {
    var id = UUID()
    var tag: Int
    var routeName: String
    var routeNameDetail: String
    var routeImage: String
}

struct RouteData {
    static let routeData = [
        Routes(
            tag: 1,
            routeName: "Foresta",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "nearest route"
            //            routeLocation: CLLocationCoordinate2D(latitude: -6.292478, longitude: 106.644931)
        ),
        Routes(
            tag: 2,
            routeName: "Nava Park",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "nearest route"
            //            routeLocation: CLLocationCoordinate2D(latitude: -6.292648, longitude: 106.652119)
        ),
        Routes(
            tag: 3,
            routeName: "Green Office Park",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "nearest route"
            //            routeLocation: CLLocationCoordinate2D(latitude: -6.301616, longitude: 106.651096)
        ),
        Routes(
            tag: 4,
            routeName: "Mozia",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "nearest route"
        ),
        Routes(
            tag: 5,
            routeName: "Vanya Park",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "nearest route"
        )
    ]
}
