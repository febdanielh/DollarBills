//
//  Utilities.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import Foundation
import MapKit

struct RouteOverlay: Identifiable {
    let id = UUID()
    let route: MKRoute
}

struct AnnotationModel: Equatable, Identifiable {
    static func == (lhs: AnnotationModel, rhs: AnnotationModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var routeName: String
    var waypoints: [CLLocationCoordinate2D]
}

class CustomAnnotation: NSObject, MKAnnotation {
    
    var tag: Int
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var annotationModel: AnnotationModel
    
    init(tag: Int, coordinate: CLLocationCoordinate2D, title: String? = nil, annotationModel: AnnotationModel) {
        
        self.tag = tag
        self.coordinate = coordinate
        self.title = title
        self.annotationModel = annotationModel
        
    }
    
}

struct CustomAnnotationAndRoute {
    static let customAnnotation = [
        CustomAnnotation(tag: 1,
                         coordinate: CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505),
                         title: "Route 1",
                         annotationModel: AnnotationModel(
                            id: 1,
                            routeName: "Keliling Foresta",
                            waypoints: [
                                CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505),
                                CLLocationCoordinate2D(latitude: -6.293920, longitude: 106.642447),
                                CLLocationCoordinate2D(latitude: -6.293920, longitude: 106.642447),
                                CLLocationCoordinate2D(latitude: -6.290890, longitude: 106.645503),
                                CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505)
                            ])),
        CustomAnnotation(tag: 2,
                         coordinate: CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344),
                         title: "Route 2",
                         annotationModel: AnnotationModel(
                            id: 2,
                            routeName: "Keliling Nava",
                            waypoints: [
                                CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344),
                                CLLocationCoordinate2D(latitude: -6.290008, longitude: 106.653541),
                                CLLocationCoordinate2D(latitude: -6.291005, longitude: 106.651307),
                                CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344)
                            ]))
    ]
}

