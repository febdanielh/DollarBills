//
//  HKHelper.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import Foundation
import HealthKit
import CoreLocation
import MapKit

struct HKHelper {
    static let healthStore = HKHealthStore()
    static let available = HKHealthStore.isHealthDataAvailable()
    
    // The requestAuth() method asks the user for authorization to access their health data.
    static func requestAuth() async -> HKAuthorizationStatus {
        let types: Set = [
            HKObjectType.workoutType(),
            HKSeriesType.workoutRoute(),
        ]
        
        // Request permission to access the data types defined above.
        try? await healthStore.requestAuthorization(toShare: types, read: types)
        return status
    }
    
    // The status method returns the current status of authorization to access health data.
    static var status: HKAuthorizationStatus {
        
        let workoutStatus = healthStore.authorizationStatus(for: HKObjectType.workoutType())
        let routeStatus = healthStore.authorizationStatus(for: HKSeriesType.workoutRoute())
        
        // Determine whether both data types have been allowed to be shared.
        if workoutStatus == .sharingAuthorized && routeStatus == .sharingAuthorized{
            return .sharingAuthorized
        } else if workoutStatus == .notDetermined && routeStatus == .notDetermined{
            return .notDetermined
        } else {
            return .sharingDenied
        }
    }
    
    // The loadWorkouts method loads a list of workouts from the user's health data.
    static func loadWorkouts(completion: @escaping ([HKWorkout]) -> Void) {
        
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sort]) { query, samples, error in
            guard let workouts = samples as? [HKWorkout] else {
                completion([])
                return
            }
            completion(workouts)
        }
        healthStore.execute(query)
    }
    
    // The loadWorkoutRoute method loads a workout route from the user's health data.
    static func loadWorkoutRoute(hkWorkout: HKWorkout, completion: @escaping ([CLLocation]) -> Void) {
        
        let type = HKSeriesType.workoutRoute()
        
        let predicate = HKQuery.predicateForObjects(from: hkWorkout)
        
        let routeQuery = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            guard let route = samples?.first as? HKWorkoutRoute else {
                completion([])
                return
            }
            
            var locations = [CLLocation]()
            let locationsQuery = HKWorkoutRouteQuery(route: route) { query, newLocations, finished, error in
                locations.append(contentsOf: newLocations ?? [])
                if finished {
                    completion(locations)
                }
            }
            self.healthStore.execute(locationsQuery)
        }
        healthStore.execute(routeQuery)
    }
}
