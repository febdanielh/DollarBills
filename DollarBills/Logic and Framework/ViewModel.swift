//
//  ViewModel.swift
//  DollarBills
//
//  Created by Elvis Susanto on 11/10/23.
//

import MapKit
import HealthKit
import Combine
import SwiftUI

@MainActor//location dan map
class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var isPaused = false
    @Published var currentDisplayScreen: DisplayScreen = .viewOnboard
    @Published var selectedSegment = 0
    @Published var locationAccess : Bool = true
    @Published var routes: [MKRoute] = []
    @Published var cachedDirections: [String: [String]] = [:]
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
    
    @Published var locations: [CLLocation] = []
    
    //    @Published var counter: Int = 0
    
    @Published var itemCollected: [Items] = []
    
    // MARK: - Properties
    
    func updateTrackingMode() {
        
        var mode: MKUserTrackingMode {
            switch trackingMode {
            case .none:
                return .follow
            case .follow:
                return .followWithHeading
            default:
                return .none
            }
        }
        
    }
    
    var trackingModeImage: String {
        switch trackingMode {
        case .none:
            return "location"
        case .follow:
            return "location.fill"
        default:
            return "location.north.line.fill"
        }
    }
    
    // Workout Tracking
    @Published var recording = false // Whether or not workout tracking is currently active
    @Published var activityType = HKWorkoutActivityType.running // The type of workout followed
    @Published var startDate = Date() // The tracking start date/time
    @Published var meters = 0.0 // The distance traveled during tracking
    @Published var heartRate = 40
    @Published var calorieBurned: Double = 0.0
    @Published var totalElapsedTime: TimeInterval = 0.0
    @Published var timer: Timer?
    @Published var lastDateObserved: Date?
    @Published var currentAccumulatedTime: TimeInterval = 0.0
    
    // Calculated property that returns an MKPolyline based on the locations array
    var polyline: MKPolyline {
        let coords = locations.map(\.coordinate)
        return MKPolyline(coordinates: coords, count: coords.count)
    }
    
    // Calculated property that returns a new training object based on the current state of the ViewModel.
    var newWorkout: Workout {
        let duration = Date.now.timeIntervalSince(startDate)
        return Workout(activityType: activityType, polyline: polyline, locations: locations, date: startDate, duration: duration, heartRate: heartRate, calorieBurned: calorieBurned)
    }
    
    
    // HealthKit-related properties and permissions
    @Published var showPermissionsView = false
    @Published var healthUnavailable = !HKHelper.available
    @Published var healthStatus = HKAuthorizationStatus.notDetermined
    @Published var healthLoading = false
    
    // Calculated property that returns true if HealthKit permission has been granted
    var healthAuth: Bool { healthStatus == .sharingAuthorized }
    
    // HealthKit store used to request HealthKit authorization.
    let healthStore = HKHealthStore()
    
    // HKWorkoutBuilder and HKWorkoutRouteBuilder are used to track workouts in HealthKit.
    var workoutBuilder: HKWorkoutBuilder?
    var routeBuilder: HKWorkoutRouteBuilder?
    
    // Map
    @Published var trackingMode = MKUserTrackingMode.none
    @Published var mapType = MKMapType.standard
    @Published var accuracyAuth = false
    @Published var locationStatus = CLAuthorizationStatus.notDetermined

    // Calculated property that returns true if location permission has been granted.
    var locationAuth: Bool {locationStatus == .authorizedWhenInUse}
    // The MKMapView which displays the map
    var mapView: MKMapView?
    
    // Workouts
    // The table of workouts that the user has completed.
    @Published var workouts = [Workout]()
    
    // Boolean that indicates whether the workouts are loading.
    @Published var loadingWorkouts = true
    
    // View
    @Published var degrees = 0.0
    @Published var scale = 1.0
    @Published var pulse = false
    
    // Errors
    @Published var showErrorAlert = false
    @Published var error = MyError.noWorkouts
    func showError(_ error: MyError) {
        self.error = error
        self.showErrorAlert = true
    }
    
    func requestLocationAuthorization() {
        if locationStatus == .notDetermined { // If the location permission status is not yet determined
            locationManager.requestWhenInUseAuthorization() // Request authorization to access the location in use
        }
    }
    
    func updateHealthStatus() {
        healthStatus = HKHelper.status // Updates permission status to access health data
        if !healthAuth {// If the application does not yet have authorization to access health data
            showPermissionsView = true // Shows the permission view to access health data
        }
    }
    
    func requestHealthAuthorization() async {
        healthLoading = true // Enable loading spinner
        healthStatus = await HKHelper.requestAuth() // Wait for authorization to access health data
        if healthAuth { // If the application has permission to access health data
            loadWorkouts() // Load user history data
        }
        healthLoading = false // Disable loading spinner
    }
    
    // MARK: - Workouts
    
    // Load workouts from the HealthKit API
    func loadWorkouts() {
        loadingWorkouts = true
        HKHelper.loadWorkouts { hkWorkouts in
            // Check if any workouts have been returned
            guard !hkWorkouts.isEmpty else {
                DispatchQueue.main.async {
                    self.loadingWorkouts = false
                    
                }
                return
            }
            
            var tally = 0
            for hkWorkout in hkWorkouts {
                guard hkWorkout.workoutActivityType == .running else {
                    // Skip non-running workouts
                    tally += 1
                    if tally == hkWorkouts.count {
                        DispatchQueue.main.async {
                            
                            self.loadingWorkouts = false
                        }
                    }
                    continue
                }
                // Load workout coordinates from HealthKit API
                HKHelper.loadWorkoutRoute(hkWorkout: hkWorkout) { locations in
                    tally += 1
                    // Check if any coordinates were returned
                    if !locations.isEmpty {
                        // Create a new Workout object from the workout data and coordinates
                        if let workout = Workout(hkWorkout: hkWorkout, locations: locations) {
                            DispatchQueue.main.async {
                                self.workouts.append(workout)
                            }
                        }
                    }
                    // Check if all workouts have been processed
                    if tally == hkWorkouts.count {
                        DispatchQueue.main.async {
                            // If all workouts have been processed, stop the loading animation
                            
                            self.loadingWorkouts = false
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Workout Tracking // add the heart data recovery part

    func startTotalElapsedTimeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task {
                await self?.updateTotalElapsedTime()
            }
        }
    }

    
    private func updateTotalElapsedTime() {
        if let currentDate = lastDateObserved {
            let currentAccumulatedTime = Date().timeIntervalSince(currentDate)
            totalElapsedTime += currentAccumulatedTime
            lastDateObserved = Date()
        }
    }

    func startWorkout(type: HKWorkoutActivityType) async {
        
        updateHealthStatus()
        guard healthAuth else { return }
        
        let config = HKWorkoutConfiguration()
        config.activityType = type
        config.locationType = .outdoor
        
        routeBuilder = HKWorkoutRouteBuilder(healthStore: healthStore, device: .local())
        workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: .local())
        
        do {
            try await workoutBuilder?.beginCollection(at: .now)
        } catch {
            self.showError(.startingWorkout)
            return
        }
        
        do {
            let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
            let heartRateQuery = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
                if let error = error {
                    print("Error retrieving heart rate samples: \(error.localizedDescription)")
                    return
                }

                guard let samples = samples as? [HKQuantitySample] else { return }

                for sample in samples {
                    let heartRateUnit = HKUnit(from: "count/min")
                    let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
                    DispatchQueue.main.async { [weak self] in
                        self?.heartRate = Int(heartRate)
                    }
                }
            }

            healthStore.execute(heartRateQuery)
        } catch {
            print("Error retrieving heart rate: \(error.localizedDescription)")
        }

        locationManager.allowsBackgroundLocationUpdates = true
        updateTrackingMode(.followWithHeading)
                
        lastDateObserved = Date()
        totalElapsedTime = 0
        
        startTotalElapsedTimeTimer()

        DispatchQueue.main.async { [weak self] in
            self?.recording = true
        }
        
    }
    
    func pauseWorkout() {
        isPaused.toggle()
        if isPaused {
            locationManager.stopUpdatingLocation()
            timer?.invalidate()
            timer = nil
            lastDateObserved = Date()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func resumeWorkout() {
        
        locationManager.startUpdatingLocation()
        isPaused.toggle()
        
        lastDateObserved = Date()
        startTotalElapsedTimeTimer()
    }

    func discardWorkout() { // disallow background location updates
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.invalidate()
        recording = false
        
        heartRate = 0
        meters = 0
        locations = []
        updatePolylines()
        
        workoutBuilder?.discardWorkout()
        routeBuilder?.discard()
        
    }
    
    func endWorkout() async {
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.invalidate()
        recording = false
        
        let workout = newWorkout
        if workout.activityType == .running {
            workouts.append(workout)
            updatePolylines()
        }
        
        heartRate = 0
        meters = 0
        locations = []

        do {
            try await workoutBuilder?.endCollection(at: .now)
            if let workout = try await workoutBuilder?.finishWorkout() {
                try await routeBuilder?.finishRoute(with: workout, metadata: nil)
            }
            
        } catch {
            showError(.endingWorkout)
        }
    }
    
    // MARK: - Map
    func updateTrackingMode(_ newMode: MKUserTrackingMode) {
        mapView?.setUserTrackingMode(newMode, animated: true)
        if trackingMode == .followWithHeading || newMode == .followWithHeading {
            withAnimation(.easeInOut(duration: 0.25)) {
                scale = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.trackingMode = newMode
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.scale = 1
                }
            }
        } else {
            DispatchQueue.main.async {
                self.trackingMode = newMode
            }
        }
    }
    
    func updatePolylines() {
        mapView?.removeOverlays(mapView?.overlays(in: .aboveLabels) ?? [])
        mapView?.addOverlay(polyline, level: .aboveLabels)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard recording else { return }
        
        // Filtering rentals according to precision
        let filteredLocations = locations.filter { location in
            location.horizontalAccuracy < 50
        }
        
        DispatchQueue.main.async {
            for location in filteredLocations {
                if let lastLocation = self.locations.last {
                    self.meters += location.distance(from: lastLocation)
                }
                self.locations.append(location)
            }
            
            self.updatePolylines()
            
            // Added road data for map construction
            self.routeBuilder?.insertRouteData(self.locations) { success, error in
                guard success else {
                    print("Error inserting locations")
                    return
                }
            }
        }
        
        distance = locations.last!.distance(from: startPoint)
        distance = distance/1000
        
        if selectedAnnotation != nil {
            if locationManager.monitoredRegions.isEmpty == true {
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
        
        //        counter += 1
        //        print(counter)
        
    }
    
    func removeAnn (region: CLRegion)  {
        var index: Int = 0
        for oneRoute in selectedAnnotation!.waypoints {
            if (oneRoute.title == region.identifier) {
                locationManager.stopMonitoring(for: region)
                selectedAnnotation!.waypoints.remove(at: index)
                print("ke stop monitor!!!")
            }
            index = index + 1
        }
    }
    
    func serviceAvailabilityCheck() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
                self.updateHealthStatus() // Update health status
                
                if self.healthAuth { // If the application has authorization to access health data
                    self.loadWorkouts() // Load user history data
                }
                
            } else {
                print("Location Services not Enabled.")
            }
        }
    }
    
    func locationAuthorizationCheck() {
        if locationStatus == .notDetermined { // If the location permission status is not yet determined
            locationManager.requestWhenInUseAuthorization() // Request authorization to access the location in use
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        if locationAuth {
            manager.startUpdatingLocation()
            updateTrackingMode(.follow)
        } else {
            showPermissionsView = true
        }
        accuracyAuth = manager.accuracyAuthorization == .fullAccuracy
        if !accuracyAuth {
            showPermissionsView = true
        }
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
                locationManager.startMonitoring(for: region)
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
}

extension ViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .red
            renderer.lineWidth = 6
            return renderer
        } else if let workout = overlay as? Workout {
            
            let render = MKPolylineRenderer(polyline: workout.polyline)
            render.lineWidth = 2
            
            render.strokeColor = UIColor(.indigo)
            return render
        }
        return MKOverlayRenderer()
    }
}
