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
    var routeCount: Int
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}

struct RouteData {
    static let routeData = [
        Routes(
            tag: 1,
            routeName: "Foresta",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "foresta",
            routeCount: 1,
            latitude: -6.292478,
            longitude: 106.644931
        ),
        Routes(
            tag: 2,
            routeName: "Naturale",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "naturale",
            routeCount: 1,
            latitude: -6.292648,
            longitude: 106.652119
        ),
        Routes(
            tag: 3,
            routeName: "Green Office Park",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "green office park",
            routeCount: 0,
            latitude: -6.301616,
            longitude: 106.651096
        ),
        Routes(
            tag: 4,
            routeName: "Mozia",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "mozia",
            routeCount: 0,
            latitude: -6.29435,
            longitude: 106.62808
        ),
        Routes(
            tag: 5,
            routeName: "Vanya Park",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "vanya park",
            routeCount: 0,
            latitude: -6.295911857821161,
            longitude: 106.62130689662094
        )
    ]
    
    static let furthrPick = [
        Routes(
            tag: 10,
            routeName: "Bukit Golf",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "bukit golf",
            routeCount: 0,
            latitude: -6.281416,
            longitude: 106.652226
        ),
        Routes(
            tag: 11,
            routeName: "Living World",
            routeNameDetail: "BSD, Tangerang",
            routeImage: "living world",
            routeCount: 0,
            latitude: -6.244811,
            longitude: 106.653052
        )
    ]
}
