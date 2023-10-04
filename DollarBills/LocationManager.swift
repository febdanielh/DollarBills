//
//  LocationManager.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager?
    
    @Published var locationAccess : Bool = true
    
    @Published var selectedAnnotation: AnnotationModel?
    {
       didSet {
           print("Ganti Rute!!!")
           monitorRegionAtLocation(locations: selectedAnnotation!.waypoints)
       }
   }
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    @Published var region = MKCoordinateRegion (
        center: CLLocationCoordinate2D(
            latitude: -6.302230,
            longitude: 106.652264),
        span: MKCoordinateSpan(
            latitudeDelta: 0.02,
            longitudeDelta: 0.02)
    )
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//            removeAnn(region: region)
        print("eh masuk")
        print(region.identifier)
    }
    
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func serviceAvailabilityCheck() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.delegate = self
                self.locationManager?.startUpdatingLocation()
            } else {
                print("Location Services not Enabled.")
            }
        }
    }
    
    func locationAuthorizationCheck() {
        
        guard let locationManager = locationManager else { return }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            locationAccess = false
            print("Location accesses restricted (probably due to parental settings).")
            
        case .denied:
            locationAccess = false
            print("Location accesses restricted, enable access through settings.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationAccess = true
            
        @unknown default:
            break
            
        }
        
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorizationCheck()
    }
    
    func monitorRegionAtLocation(locations: [CLLocationCoordinate2D]) {
        print("KEPANGILL!!!")
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            for oneLocation in locations {
                let region = CLCircularRegion(center: oneLocation,
                                              radius: 50.0, identifier: "")
                region.notifyOnEntry = true
                region.notifyOnExit = false
                locationManager?.startMonitoring(for: region)
            }
        }
    }

}

