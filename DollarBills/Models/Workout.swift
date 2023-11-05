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
    let activityType: HKWorkoutActivityType
    let polyline: MKPolyline
    let locations: [CLLocation]
    let date: Date
    let duration: Double
    let distance: Double
    let elevation: Double
    let heartRate: Int
    let calorieBurned: Double
    var itemsCollected: [Items]
    
    init(activityType: HKWorkoutActivityType, polyline: MKPolyline, locations: [CLLocation], date: Date, duration: Double, heartRate: Int, calorieBurned: Double, itemsCollected: [Items]) {
        self.activityType = activityType
        self.polyline = polyline
        self.locations = locations
        self.date = date
        self.duration = duration
        self.distance = locations.distance
        self.elevation = locations.elevation
        self.heartRate = heartRate
        self.calorieBurned = calorieBurned
        self.itemsCollected = itemsCollected
    }
    
    convenience init?(hkWorkout: HKWorkout, locations: [CLLocation]) {
        guard hkWorkout.workoutActivityType == .running else {
            return nil
        }
        
        let coords = locations.map(\.coordinate)
        let activityType = hkWorkout.workoutActivityType
        let polyline = MKPolyline(coordinates: coords, count: coords.count)
        let date = hkWorkout.startDate
        let duration = hkWorkout.duration
//        let calorieBurned = hkWorkout.totalCalorieBurned
        var heartRate = 0
        var itemsCollected : [Items] = []
        
        let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
        let predicate = HKQuery.predicateForSamples(withStart: hkWorkout.startDate, end: hkWorkout.endDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .heartRate)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            if let heartRates = results as? [HKQuantitySample] {
                let averageHeartRate = heartRates.reduce(0.0) { $0 + $1.quantity.doubleValue(for: heartRateUnit) } / Double(heartRates.count)
                if averageHeartRate.isFinite {
                    heartRate = Int(averageHeartRate)
                } else {
                    heartRate = 0
                }
            }
        }
        HKHealthStore().execute(query)
        
        let workout = Workout(activityType: activityType, polyline: polyline, locations: locations, date: date, duration: duration, heartRate: heartRate, calorieBurned: 0, itemsCollected: itemsCollected)
        
//        let tommorow = Date().addingTimeInterval(86400)
//        let example = Workout(activityType: .running, polyline: MKPolyline(), locations: [], date: tommorow, duration: 3456, heartRate: 120, calorieBurned: 282, itemsCollected: [
//            ItemsData.item[0],
//            ItemsData.item[1],
//            ItemsData.item[2]
//            ]
//        )
        
        self.init(activityType: workout.activityType, polyline: workout.polyline, locations: workout.locations, date: workout.date, duration: workout.duration, heartRate: workout.heartRate, calorieBurned: workout.calorieBurned, itemsCollected: workout.itemsCollected)
    }
    
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
    
    func formattedElevation() -> String {
        let formatter = Measurement(value: elevation, unit: UnitLength.meters).formatted()
        return formatter
    }
}
