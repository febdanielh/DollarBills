//
//  Workout.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import Foundation
import HealthKit
import MapKit
import CoreLocation

class Workout: NSObject {
    let activityType: HKWorkoutActivityType // exercise type
    let polyline: MKPolyline // route polyline
    let locations: [CLLocation] // list of locations
    let date: Date // date of the exercise
    let duration: Double // exercise duration in seconds
    let distance: Double // total distance traveled during exercise
    let elevation: Double // total elevation of the exercise
    
    init(activityType: HKWorkoutActivityType, polyline: MKPolyline, locations: [CLLocation], date: Date, duration: Double) {
        self.activityType = activityType
        self.polyline = polyline
        self.locations = locations
        self.date = date
        self.duration = duration
        self.distance = locations.distance
        self.elevation = locations.elevation
    }
    
    convenience init?(hkWorkout: HKWorkout, locations: [CLLocation]) {
        guard hkWorkout.workoutActivityType == .running else {
                    return nil // Return nil for non-running workouts
                }

        let coords = locations.map(\.coordinate)
        let activityType = hkWorkout.workoutActivityType
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        let date = hkWorkout.startDate
        let duration = hkWorkout.duration
        
        self.init(activityType: activityType, polyline: polyline, locations: locations, date: date, duration: duration)
    }
    
    static let example = Workout(activityType: .running, polyline: MKPolyline(), locations: [], date: .now, duration: 3456)
}

extension Workout: MKOverlay {
    var coordinate: CLLocationCoordinate2D {
        polyline.coordinate
    }
    
    var boundingMapRect: MKMapRect {
        polyline.boundingMapRect
    }
}

extension Workout {
    func formattedDuration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: duration) ?? "00:00"
    }
    
    func formattedDistance() -> String {
            let distanceInKilometers = Measurement(value: distance, unit: UnitLength.meters).converted(to: .kilometers).value
            let formattedDistance = String(format: "%.2f km", distanceInKilometers)
            return formattedDistance
        }
    
    func formattedPace() -> String {
            guard distance > 0, duration > 0 else {
                return "N/A"
            }

            let paceValue = duration / 60 / distance * 1000 // Convert distance to kilometers
            let paceMinutes = Int(paceValue)
            let paceSeconds = Int((paceValue - Double(paceMinutes)) * 60)

            return String(format: "%d'%02d\"", paceMinutes, paceSeconds)
        }

}
