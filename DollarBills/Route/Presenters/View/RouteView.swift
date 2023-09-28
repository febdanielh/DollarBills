//
//  RouteView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 28/09/23.
//

import CoreLocation
import MapKit
import SwiftUI

struct RouteView: UIViewRepresentable {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.29389, longitude: 106.64557),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var distance: CLLocationDistance = 0.0
    @State private var elevation: CLLocationDistance = 0.0

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Set the map's region to your @State region
        uiView.setRegion(region, animated: true)

        // Create a sample route with coordinates
        let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29408, longitude: 106.64174), addressDictionary: nil)
        let connectorOnePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29016, longitude: 106.64689), addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29656, longitude: 106.64660), addressDictionary: nil)

        // Create map items from the placemarks
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let connectorOneMapItem = MKMapItem(placemark: connectorOnePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        // Create a request for directions from source to connectorOne
        let request1 = MKDirections.Request()
        request1.source = sourceMapItem
        request1.destination = connectorOneMapItem
        request1.transportType = .automobile

        // Create a directions object using the request
        let directions1 = MKDirections(request: request1)

        // Calculate the directions and handle the response
        directions1.calculate { (response, error) in
            guard let route = response?.routes.first else {
                return
            }

            // Add the route to the map
            uiView.addOverlay(route.polyline, level: .aboveRoads)
        }

        // Create a request for directions from connectorOne to destination
        let request2 = MKDirections.Request()
        request2.source = connectorOneMapItem
        request2.destination = destinationMapItem
        request2.transportType = .automobile

        // Create a directions object using the request
        let directions2 = MKDirections(request: request2)

        // Calculate the directions and handle the response
        directions2.calculate { (response, error) in
            guard let route = response?.routes.first else {
                return
            }

            // Add the route to the map
            uiView.addOverlay(route.polyline, level: .aboveRoads)
        }

        // Create a request for directions from destination back to source
        let request3 = MKDirections.Request()
        request3.source = destinationMapItem
        request3.destination = sourceMapItem
        request3.transportType = .automobile

        // Create a directions object using the request
        let directions3 = MKDirections(request: request3)

        // Calculate the directions and handle the response
        directions3.calculate { (response, error) in
            guard let route = response?.routes.first else {
                return
            }

            // Add the route to the map
            uiView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: RouteView

    init(_ parent: RouteView) {
        self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 6
            return renderer
        }
        return MKOverlayRenderer()
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}


//import SwiftUI
//import MapKit
//
//struct RouteView: UIViewRepresentable {
//
//    @State private var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: -6.29340, longitude: 106.64242),
//            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
//        )
//
//    // Create a Directions object
//    let directions = MKDirections(request: MKDirections.Request())
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//            // Set the map's region to your @State region
//            uiView.setRegion(region, animated: true)
//
//            // Create a sample route with coordinates
//            let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29408, longitude: 106.64174), addressDictionary: nil)
//        let connectorOnePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29016, longitude: 106.64689), addressDictionary: nil)
//        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.29656, longitude: 106.64660), addressDictionary: nil)
//
//            // Create map items from the placemarks
//            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
//            let connectorOneMapItem = MKMapItem(placemark: connectorOnePlacemark)
//            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//
//            // Create a request for directions
//            let request = MKDirections.Request()
//            request.source = sourceMapItem
//            request.destination = destinationMapItem
//            request.transportType = .automobile
//
//            // Create a directions object using the request
//            let directions = MKDirections(request: request)
//
//            // Calculate the directions and handle the response
//            directions.calculate { (response, error) in
//                guard let route = response?.routes.first else {
//                    return
//                }
//
//                // Add the route to the map
//                uiView.addOverlay(route.polyline, level: .aboveRoads)
//
//                // Adjust the map's visible region to fit the route
//                uiView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
//            }
//        }
//
//
////    func updateUIView(_ uiView: MKMapView, context: Context) {
////        // You can update the map's properties here if needed
////        // For example, set the map's region or add annotations
////
////        // Set the map's region to your @State region
////            uiView.setRegion(region, animated: true)
////
////        // Create a sample route with coordinates
////        let coordinates = [
////            CLLocationCoordinate2D(latitude: -6.29408, longitude: 106.64174), // Start point
////            CLLocationCoordinate2D(latitude: -6.29385, longitude: 106.64275),
////            CLLocationCoordinate2D(latitude: -6.29359, longitude: 106.64389),
////            CLLocationCoordinate2D(latitude: -6.29268, longitude: 106.64437),
////            CLLocationCoordinate2D(latitude: -6.29481, longitude: 106.64191) // End point
////        ]
////
////        // Create a polyline and add it to the map
////        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
////        uiView.addOverlay(polyline)
////    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//}
//
//class Coordinator: NSObject, MKMapViewDelegate {
//    var parent: RouteView
//
//    init(_ parent: RouteView) {
//        self.parent = parent
//    }
//
//    // Implement the rendererForOverlay method to style the route polyline
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if let polyline = overlay as? MKPolyline {
//            let renderer = MKPolylineRenderer(polyline: polyline)
//            renderer.strokeColor = UIColor.blue // Set the route's color
//            renderer.lineWidth = 6 // Set the route's line width
//            return renderer
//        }
//        return MKOverlayRenderer()
//    }
//}
//
//
//struct RouteView_Previews: PreviewProvider {
//    static var previews: some View {
//        RouteView()
//    }
//}
