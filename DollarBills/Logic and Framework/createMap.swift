//
//  createMap.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import SwiftUI
import MapKit

struct createMap: UIViewRepresentable {
    @Binding var directions: [String]
    
    @Binding var routes: [MKRoute]
    
    @Binding var selectedAnnotation: AnnotationModel
    
    //    @Binding var showDirections: Bool
    
    @Binding var cachedDirections: [String: [String]]
    
    var annotations: [CustomAnnotation] = CustomAnnotationAndRoute.customAnnotation
    
    @EnvironmentObject var vm: ViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = vm.mapView
        mapView.delegate = vm
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsCompass = true
        mapView.isPitchEnabled = false
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
//        mapView.removeAnnotations(annotations)
//        mapView.addAnnotations(annotations)
        
        for annotation in annotations {
            if annotation.annotationModel.id == selectedAnnotation.id {
                if let cached = cachedDirections[annotation.annotationModel.routeName] {
                    directions = cached
                } else {
                    //                    showDirections = true
                    calculateDirections(mapView, annotation: annotation)
                }
            }
        }
        
        var boundingBox = MKMapRect.null
        
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        for route in routes {
            if routes.count > 1{
                boundingBox = boundingBox.union(route.polyline.boundingMapRect)
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(
                    boundingBox,
                    edgePadding: padding,
                    animated: true)
            } else {
                mapView.removeOverlays(mapView.overlays)
            }
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

