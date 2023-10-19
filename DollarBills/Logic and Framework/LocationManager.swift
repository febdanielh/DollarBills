//
//  LocationManager.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, Encodable {
    
    private var locationManager: CLLocationManager?
    
    @Published var locationAccess : Bool = true
    
    @Published var distance: Double = 0.0
    
    @Published var startPoint: CLLocation = CLLocation(latitude: -6.302230, longitude: 106.652264)
    
    @Published var selectedAnnotation: AnnotationModel?
    {
        didSet {
            startPoint = CLLocation(latitude: selectedAnnotation!.waypoints.first!.coordinate.latitude, longitude: selectedAnnotation!.waypoints.first!.coordinate.longitude)
            if ((selectedAnnotation?.waypoints.count)! > 1) {
                print("Ganti Rute!!!")
                monitorRegionAtLocation(locations: selectedAnnotation!)
            }
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
    
    @Published var counter: Int = 0
    
    @Published var itemCollected: [Items] = []
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        distance = locations.last!.distance(from: startPoint)
        distance = distance/1000
        
        if let location = locations.first {
            userLocation = location.coordinate
        }
        
        if selectedAnnotation != nil {
            if locationManager?.monitoredRegions.isEmpty == true {
                print("semua item sudah di collect")
            } else {
                print("belum semua item di collect")
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("eh masuk :")
        print(region.identifier)
        print("sisa:")
        //        print(locationManager?.monitoredRegions)
        
        addRandomItem()
        print(itemCollected)
        print("nambah item")
        
        removeAnn(region: region)
        
        counter += 1
        print(counter)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    }
    
    func removeAnn (region: CLRegion)  {
        var index: Int = 0
        for oneRoute in selectedAnnotation!.waypoints {
            if (oneRoute.title == region.identifier) {
                locationManager?.stopMonitoring(for: region)
                selectedAnnotation?.waypoints.remove(at: index)
                print("ke stop monitor!!!")
            }
            index = index + 1
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
    
    func monitorRegionAtLocation(locations: AnnotationModel) {
        print("KEPANGILL!!!")
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            for oneLocation in locations.waypoints {
                
                let region = CLCircularRegion(center: oneLocation.coordinate,
                                              radius: 5.0, identifier: oneLocation.title!)
                region.notifyOnEntry = true
                region.notifyOnExit = false
                locationManager?.startMonitoring(for: region)
            }
        }
    }
    
    func addRandomItem() {
        guard let randomItem = ItemsData.item.randomElement() else {
            return
        }
        itemCollected.append(randomItem)
        print("Added random item: \(randomItem.namaItem)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // Encode any properties that you want to be included when encoding LocationManager
        // For example, if you want to encode the 'distance' property:
        try container.encode(distance, forKey: .distance)
//        try container.encode(region, forKey: .region)
        // Encode other properties as needed
    }
    
    // Define CodingKeys to specify which properties to encode
    private enum CodingKeys: String, CodingKey {
        case distance
//        case region
        // Add other properties you want to encode here
    }
    
}

