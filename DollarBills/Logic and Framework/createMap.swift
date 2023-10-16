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
            parent.showDirections = true
        }
        
        mapView.removeOverlays(mapView.overlays)
    }

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .red
            renderer.lineWidth = 5
            return renderer
        } else if let workout = overlay as? Workout {
            
            let render = MKPolylineRenderer(polyline: workout.polyline)
            render.lineWidth = 2
            
            render.strokeColor = UIColor(.indigo)
            return render
        }
        
        return MKOverlayRenderer()
    }
    
    
    //    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    //        parent.selectedAnnotation = AnnotationModel(id: UUID(uuidString: "")!, routeName: "", waypoints: [])
    //        parent.showDirections = false
    //
    //        parent.routes.removeAll()
    //        parent.directions.removeAll()
    //        parent.cachedDirections.removeAll()
    //    }
    
}

struct createMap: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    @Binding var directions: [String]
    
    @State var routes: [MKRoute] = []
    
    @Binding var selectedAnnotation: AnnotationModel?
    
    @Binding var showDirections: Bool
    
    @State var cachedDirections: [String: [String]] = [:]
    
    var annotations: [CustomAnnotation] = CustomAnnotationAndRoute.customAnnotation
    
    @EnvironmentObject var vm: ViewModel

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = vm
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsCompass = true
        mapView.isPitchEnabled = false
        
        vm.mapView = mapView
        
//        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(ViewModelWorkout.handleTap))
//        mapView.addGestureRecognizer(tapRecognizer)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
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

