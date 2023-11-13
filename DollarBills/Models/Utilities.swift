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

class CustomAnnotation: NSObject, MKAnnotation, Identifiable {
    
    var tag: Int
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var location: String?
    var annotationModel: AnnotationModel
    
    init(tag: Int, coordinate: CLLocationCoordinate2D, title: String? = nil, location: String?, annotationModel: AnnotationModel) {
        self.tag = tag
        self.coordinate = coordinate
        self.title = title
        self.location = location
        self.annotationModel = annotationModel
    }
    
}

struct CustomAnnotationAndRoute {
    static let customAnnotation = [
        CustomAnnotation(tag: 1,
                         coordinate: CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505),
                         title: "Foresta",
                         location: "BSD, Tangerang",
                         annotationModel:
                            AnnotationModel (
                                routeName: "Foresta Run",
                                waypoints: [
                                    Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.29675, longitude: 106.64505)),
                                    Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.293920, longitude: 106.642447)),
                                    Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.290890, longitude: 106.645503)),
                                    Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude: -6.296, longitude: 106.6467))
                                ]
                            )
                        ),
        CustomAnnotation(tag: 2,
                         coordinate: CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344),
                         title: "Nava",
                         location: "BSD, Tangerang",
                         annotationModel:
                            AnnotationModel(
                                routeName: "Nava Run",
                                waypoints: [
                                    Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.291824, longitude: 106.65344)),
                                    Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.290008, longitude: 106.653541)),
                                    Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.291005, longitude: 106.651307)),
                                    Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude: -6.29206, longitude: 106.65311))
                                ]
                            )
                        ),
        CustomAnnotation(tag: 3,
                         coordinate: CLLocationCoordinate2D(latitude: -6.302834, longitude: 106.651986),
                         title: "Green Office Park",
                         location: "BSD, Tangerang",
                         annotationModel:
                            AnnotationModel(
                                routeName: "GOP Run",
                                waypoints: [
                                    Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.302834, longitude: 106.651986)),
                                    Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.301771, longitude:  106.650747)),
                                    Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude:  -6.300367, longitude:   106.652501)),
                                    Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude: -6.302823, longitude:  106.652180))
                                ]
                            )
                        ),
        CustomAnnotation(tag: 3,
                         coordinate: CLLocationCoordinate2D(latitude: -6.302715, longitude: 106.652442),
                         title: "Green Office Park",
                         location: "BSD, Tangerang",
                         annotationModel:
                            AnnotationModel(
                                routeName: "GOP - Breeze Run",
                                waypoints: [
                                    Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.302715, longitude: 106.652442)),
                                    Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.301491, longitude:   106.653004)),
                                    Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.301299, longitude: 106.653403)),
                                    Checkpoint(title: "Checkpoint 4", coordinate: CLLocationCoordinate2D(latitude:  -6.300424, longitude:   106.653981)),
                                    Checkpoint(title: "Checkpoint 5", coordinate: CLLocationCoordinate2D(latitude: -6.300605, longitude:  106.654678)),
                                    Checkpoint(title: "Checkpoint 6", coordinate: CLLocationCoordinate2D(latitude: -6.302116, longitude:  106.655741)),
                                    Checkpoint(title: "Checkpoint 7", coordinate: CLLocationCoordinate2D(latitude: -6.303503, longitude:  106.655804)),
                                    Checkpoint(title: "Checkpoint 8", coordinate: CLLocationCoordinate2D(latitude: -6.303551, longitude: 106.654105)),
                                    Checkpoint(title: "Checkpoint 9", coordinate: CLLocationCoordinate2D(latitude: -6.303545, longitude:  106.652362)),
                                    Checkpoint(title: "Checkpoint 10", coordinate: CLLocationCoordinate2D(latitude: -6.302625, longitude: 106.652549))
                                ]
                            )
                        ),
        CustomAnnotation(tag: 3,
                         coordinate: CLLocationCoordinate2D(latitude: -6.301924, longitude: 106.652088),
                         title: "Green Office Park",
                         location: "BSD, Tangerang",
                         annotationModel:
                            AnnotationModel(
                                routeName: "Apple - Halte Run",
                                waypoints: [
                                    Checkpoint(title: "Checkpoint 1", coordinate: CLLocationCoordinate2D(latitude: -6.301924, longitude: 106.652088)),
                                    Checkpoint(title: "Checkpoint 2", coordinate: CLLocationCoordinate2D(latitude: -6.301948, longitude:    106.651732)),
                                    Checkpoint(title: "Checkpoint 3", coordinate: CLLocationCoordinate2D(latitude: -6.301866, longitude:  106.651536)),
                                    
                                ]
                            )
                        )
    ]
}

