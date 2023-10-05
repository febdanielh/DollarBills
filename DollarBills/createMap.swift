//
//  createMap.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    
    var parent: createMap
    
    init(parent: createMap) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("kepencet brodi")
        parent.routes.removeAll()
        parent.directions.removeAll()
        parent.cachedDirections.removeAll()
        if let annotation = view.annotation as? CustomAnnotation {
            parent.selectedAnnotation = annotation.annotationModel
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .red
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
    
}

struct createMap: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    @Binding var directions: [String]
    
    @State var routes: [MKRoute] = []
    
    let region: MKCoordinateRegion
    
    @Binding var selectedAnnotation: AnnotationModel?
    
    @State var cachedDirections: [String: [String]] = [:]
    
    var annotations: [CustomAnnotation] = CustomAnnotationAndRoute.customAnnotation
    
    func makeUIView(context: Context) -> MKMapView {
        // Feb Done
        // Elv Done
        // Rez
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.region = region
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        mapView.removeOverlays(mapView.overlays)
        
        mapView.removeAnnotations(annotations)
        
        mapView.addAnnotations(annotations)
        
        for annotation in annotations {
            if annotation.annotationModel.id == selectedAnnotation?.id {
                
                
                if let cached = cachedDirections[annotation.annotationModel.routeName] {
                    directions = cached
                } else {
                    calculateDirections(mapView, annotation: annotation)
                }
            }
            
        }
        
        var boundingBox = MKMapRect.null
        
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        for route in routes {
            boundingBox = boundingBox.union(route.polyline.boundingMapRect)
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                boundingBox,
                edgePadding: padding,
                animated: true)
        }
        
    }
    
    func calculateDirections(_ mapView: MKMapView, annotation: CustomAnnotation) {
        
        let annotationModel = annotation.annotationModel
        
        for i in 0..<annotationModel.waypoints.count{
            if i < annotationModel.waypoints.count - 1 {
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: annotationModel.waypoints[i].coordinate))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotationModel.waypoints[i+1].coordinate))
                request.transportType = .walking
                
                let directions = MKDirections(request: request)
                directions.calculate { (response, error) in
                    guard let route = response?.routes.first else { return }
                    self.routes.append(route)
                    mapView.addOverlay(route.polyline)
                    mapView.setVisibleMapRect(
                        route.polyline.boundingMapRect,
                        edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                        animated: true)
                    
                    let direction = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                    self.directions.append(contentsOf: direction)
                    
                    self.cachedDirections[annotation.annotationModel.routeName] = self.directions
                }
            }
        }
    }
    
}

