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
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    @Published var currentDisplayScreen: DisplayScreen = .viewMain
    
    @Published var selectedSegment = 0
    @Published var locationAccess : Bool = true
    
    @Published var routes: [MKRoute] = []
    @Published var cachedDirections: [String: [String]] = [:]
    @Published var tag: Int = 0
    @Published var distance: Double = 0.0
    
    @Published var isRouteSelected: Bool = false
    
    @Published var startPoint: CLLocation = CLLocation(latitude: -6.302230, longitude: 106.652264)
    
    @Published var annotations = CustomAnnotationAndRoute.customAnnotation
    @Published var selectedAnnotation: AnnotationModel = AnnotationModel(routeName: "", waypoints: [])
    {
        didSet {
            startPoint = CLLocation(latitude: (selectedAnnotation.waypoints.first?.coordinate.latitude ?? 0.0), longitude: (selectedAnnotation.waypoints.first?.coordinate.longitude ?? 0.0))
            if ((selectedAnnotation.waypoints.count) > 1) {
                print("Ganti Rute!!!")
                monitorRegionAtLocation(locations: selectedAnnotation)
            }
        }
    }
    
    @Published var selectedRoute: Routes = Routes(tag: 0, routeName: "", routeNameDetail: "", routeImage: "", routeCount: 0, latitude: 0.0, longitude: 0.0)
    
    @Published var locations: [CLLocation] = []
    
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
    
    
    // Calculated property that returns an MKPolyline based on the locations array
    var polyline: MKPolyline {
        let coords = locations.map(\.coordinate)
        return MKPolyline(coordinates: coords, count: coords.count)
    }
    
    // Calculated property that returns a new training object based on the current state of the ViewModel.
    var newWorkout: Workout {
        let duration = Date.now.timeIntervalSince(startDate)
        return Workout(activityType: activityType, polyline: polyline, locations: locations, date: startDate, duration: duration)
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
    
    // Cancelable used to cancel the timer that updates the elapsed time of the workout while recording.
    var timer: Cancellable?
    
    // Map
    // Map-related properties
    @Published var trackingMode = MKUserTrackingMode.none
    @Published var mapType = MKMapType.standard
    @Published var accuracyAuth = false
    @Published var locationStatus = CLAuthorizationStatus.notDetermined
    
    // Calculated property that returns true if location permission has been granted.
    var locationAuth: Bool {locationStatus == .authorizedWhenInUse}
    // The MKMapView which displays the map
    var mapView: MKMapView = MKMapView()
    
    // Workouts
    // The table of workouts that the user has completed.
    @Published var workouts = [Workout]()
    
    // The array of workouts that were filtered based on workoutType and workoutDate.
    @Published var filteredWorkouts = [Workout]()
    
    // Boolean that indicates whether the workouts are loading.
    @Published var loadingWorkouts = true
    
    // The currently selected workout
    @Published var selectedWorkout: Workout? { didSet {
        updatePolylines()
        filterWorkouts()
    }}
    
    // The currently selected workout date filter.
    @Published var workoutDate: WorkoutDate? { didSet {
        filterWorkouts()
    }}
    
    // View
    @Published var degrees = 0.0
    @Published var scale = 1.0
    @Published var pulse = false
    @Published var showInfoView = false
    @Published var showAccountView = false
    
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
                                if self.showWorkout(workout) {
                                    self.filteredWorkouts.append(workout)
                                    self.mapView.addOverlay(workout, level: .aboveRoads)
                                }
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
    
    // Filter workouts based on search criteria
    func filterWorkouts() {
        // Remove existing workouts from the map
        mapView.removeOverlays(mapView.overlays(in: .aboveRoads) /*?? []*/)
        // Filter workouts based on search criteria
        filteredWorkouts = workouts.filter { showWorkout($0) }
        // Add filtered workouts to the map
        mapView.addOverlays(filteredWorkouts, level: .aboveRoads)
        // Checks if the selected workout is no longer visible and deselects it if so
        if let selectedWorkout, !filteredWorkouts.contains(selectedWorkout) {
            self.selectedWorkout = nil
        }
    }
    
    
    // Determines whether a workout should be displayed based on search criteria
    func showWorkout(_ workout: Workout) -> Bool {
        // Checks if the current workout is selected or if no workout has been selected
        // Also checks if the workout type matches the selected workout type or if no type has been selected
        // Finally checks if the workout date matches the selected date or if no date has been selected
        
        (selectedWorkout == nil || workout == selectedWorkout) &&
        //        (workoutType == nil || workoutType == workout.type) &&
        (workoutDate == nil || Calendar.current.isDate(workout.date, equalTo: .now, toGranularity: workoutDate!.granularity))
    }
    
    func selectClosestWorkout(to targetCoord: CLLocationCoordinate2D) {
        let targetLocation = targetCoord.location
        var shortestDistance = Double.infinity
        var closestWorkout: Workout?
        
        // Check if the map is currently visible, otherwise stop the function
        /*guard*/ let rect = mapView.visibleMapRect /*else { return }*/
        let left = MKMapPoint(x: rect.minX, y: rect.midY)
        let right = MKMapPoint(x: rect.maxX, y: rect.midY)
        let maxDelta = left.distance(to: right) / 20
        
        
        // Iterates through all filtered workouts
        for workout in filteredWorkouts {
            // Iterates through all locations of each workout
            for location in workout.locations {
                let delta = location.distance(from: targetLocation)
                
                // Updates the closest workout if it is closer than the previous workout and if it is inside the maximum detection zone
                if delta < shortestDistance && delta < maxDelta {
                    shortestDistance = delta
                    closestWorkout = workout
                }
            }
        }
        selectWorkout(closestWorkout)
    }
    
    func selectWorkout(_ workout: Workout?) {
        // Select the specified workout
        selectedWorkout = workout
        // Zoom into the selected workout if a workout is selected
        if let workout {
            zoomTo(workout)
        }
    }
    
    func zoomTo(_ overlay: MKOverlay) {
        var bottomPadding = 20.0
        // Add additional padding if a workout is selected
        if selectedWorkout != nil {
            bottomPadding += 160
        }
        // Add additional padding if recording is active
        if recording {
            bottomPadding += 160
        }
        // Sets the padding for zooming and zooms to the specified overlay
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: bottomPadding, right: 20)
        mapView.setVisibleMapRect(overlay.boundingMapRect, edgePadding: padding, animated: true)
        mapView.isUserInteractionEnabled = true
    }
    
    // MARK: - Workout Tracking // add the heart data recovery part
    
    func startWorkout(type: HKWorkoutActivityType) async {
        updateHealthStatus()
        guard healthAuth else { return }
        
        let config = HKWorkoutConfiguration() // create a configuration for the workout
        config.activityType = type // sets the activity type based on the input parameter
        config.locationType = .outdoor // sets the location type to outdoor
        //        self.type = WorkoutType(hkType: type) // sets the workout type to the appropriate type
        
        routeBuilder = HKWorkoutRouteBuilder(healthStore: healthStore, device: .local()) // create a route builder to capture GPS data
        workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: .local()) // create a workout builder to capture workout data
        do {
            try await workoutBuilder?.beginCollection(at: .now)
        } catch {
            self.showError(.startingWorkout)
            return
        }
        
        
        locationManager.allowsBackgroundLocationUpdates = true
        updateTrackingMode(.followWithHeading) // updates the map view to track the user's location
        
        
        startDate = .now // set the start date of the workout
        
        // Dispatch the update to recording on the main thread
        DispatchQueue.main.async { [weak self] in
            self?.recording = true
        }
        
        timer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect().sink { _ in // creates a timer to pulse the UI every 0.5 seconds
            self.pulse.toggle()
        }
        
    }
    
    
    func discardWorkout() { // disallow background location updates
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.cancel()
        recording = false
        
        meters = 0
        locations = []
        updatePolylines()
        
        workoutBuilder?.discardWorkout()
        routeBuilder?.discard()
        
    }
    
    func endWorkout() async {
        locationManager.allowsBackgroundLocationUpdates = false
        
        timer?.cancel()
        recording = false
        
        let workout = newWorkout
        if workout.activityType == .running {
            workouts.append(workout)
            updatePolylines()
            filterWorkouts()
            selectWorkout(workout)
        }
        
        meters = 0
        locations = []
        
        do {
            try await workoutBuilder?.endCollection(at: .now) // ends training data collection
            if let workout = try await workoutBuilder?.finishWorkout() { // finish workout
                try await routeBuilder?.finishRoute(with: workout, metadata: nil) // finish GPS data
            }
            
        } catch {
            showError(.endingWorkout) // show an error message if there is a problem completing the workout
        }
    }
    
    // MARK: - Map
    func updateTrackingMode(_ newMode: MKUserTrackingMode) {
        // Update map view user tracking mode
        mapView.setUserTrackingMode(newMode, animated: true)
        // Animates the tracking mode change with a scaling effect
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
    
    func getUserDistance (latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Double {
        return (locationManager.location?.distance(from: CLLocation(latitude: latitude, longitude: longitude)))!/1000
    }
    
    func updatePolylines() {
        // Remove existing overlays and add updated polylines to the map view
        mapView.removeOverlays(mapView.overlays(in: .aboveLabels) /*?? []*/)
        mapView.addOverlay(polyline, level: .aboveLabels)
        // Add the polyline of the selected workout, if applicable
        if let selectedWorkout {
            mapView.addOverlay(selectedWorkout.polyline, level: .aboveLabels)
        }
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        // Select the workout closest to the selected location on the map view
        /*guard*/ let mapView = mapView /*else { return }*/
        let tapPoint = tap.location(in: mapView)
        let tapCoord = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        selectClosestWorkout(to: tapCoord)
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
        
        if selectedAnnotation != AnnotationModel(routeName: "", waypoints: []) {
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
        //        print("sisa:")
        //        print(locationManager?.monitoredRegions)
        
        addRandomItem()
        print(itemCollected)
        print("nambah item")
        
        removeAnn(region: region)
    }
    
    func removeAnn (region: CLRegion)  {
        var index: Int = 0
        for oneRoute in selectedAnnotation.waypoints {
            if (oneRoute.title == region.identifier) {
                locationManager.stopMonitoring(for: region)
                selectedAnnotation.waypoints.remove(at: index)
                print("ke stop monitor!!!")
            }
            index = index + 1
        }
    }
    
    func serviceAvailabilityCheck() {
        DispatchQueue.main.async {
            self.locationAuthorizationCheck()
            
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
    
    func deselectAll() {
        selectedAnnotation = AnnotationModel(routeName: "", waypoints: [])
        cachedDirections.removeAll()
        routes.removeAll()
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
