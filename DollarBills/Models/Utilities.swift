//
//  Utilities.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import Foundation
import MapKit

struct AnnotationModel: Identifiable, Hashable {
    var id = UUID()
    var routeName: String
    var waypoints: [Checkpoint]
    
}

final class Checkpoint: NSObject, MKAnnotation, Identifiable {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
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
                            routeName: "Keliling Foresta",
                            waypoints: [
                                Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505)),
                                Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.293920, longitude: 106.642447)),
                                Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.290890, longitude: 106.645503)),
                                Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude: -6.296, longitude: 106.6467))
                            ]
                         )),
        CustomAnnotation(tag: 2,
                         coordinate: CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344),
                         title: "Route 2",
                         annotationModel: AnnotationModel(
                            routeName: "Keliling Nava",
                            waypoints: [
                                Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344)),
                                Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.290008, longitude: 106.653541)),
                                Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.291005, longitude: 106.651307)),
                                Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude: -6.29206, longitude: 106.65311))
                            ]
                         ))
    ]
}

