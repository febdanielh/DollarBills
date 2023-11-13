//
//  LocationManager.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 12/11/23.
//

import Foundation
import MapKit
import HealthKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    
    @Published var locationAccess: Bool = true
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var routeBuilder: HKWorkoutRouteBuilder?
    
    func checkServiceAvailability() {
//        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
//                self.locationManager?.startUpdatingLocation()
            } else {
                print("Location Services not Enabled.")
            }
//        }
    }
    
    private func checkLocationAuthorization() {
        
        guard let locationManager = locationManager else { return }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationAccess = false
            print("Location accesses restricted (probably due to parental settings).")
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            locationAccess = false
            print("Location accesses restricted, enable access through settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            locationAccess = true
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let filteredLocations = locations.filter { location in
            location.horizontalAccuracy <= 50
        }
        
        guard !filteredLocations.isEmpty else { return }

        routeBuilder?.insertRouteData(filteredLocations) { (success, error) in
            if !success {
                print("Error inserting locations")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
