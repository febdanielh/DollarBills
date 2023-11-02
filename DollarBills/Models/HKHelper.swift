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
    
    static func requestAuth() async -> HKAuthorizationStatus {
        let typesToShare: Set = [
            HKObjectType.workoutType(),
            HKSeriesType.workoutRoute(),
        ]
        
        let typesToRead: Set = [
            HKQuantityType(.heartRate),
            HKQuantityType(.activeEnergyBurned),
            HKQuantityType(.distanceWalkingRunning),
            HKQuantityType.workoutType(),
            HKSeriesType.workoutRoute(),
            HKObjectType.activitySummaryType()
        ]

        try? await healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead)
        return status
    }
    
    static var status: HKAuthorizationStatus {
        
        let workoutStatus = healthStore.authorizationStatus(for: HKObjectType.workoutType())
        let routeStatus = healthStore.authorizationStatus(for: HKSeriesType.workoutRoute())
        
        if workoutStatus == .sharingAuthorized && routeStatus == .sharingAuthorized{
            return .sharingAuthorized
        } else if workoutStatus == .notDetermined && routeStatus == .notDetermined{
            return .notDetermined
        } else {
            return .sharingDenied
        }
    }
    
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
    
    static func loadHeartRateData(completion: @escaping ([HKQuantitySample]) -> Void) {
        
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion([])
            return
        }
        
        let heartRateStatus = healthStore.authorizationStatus(for: heartRateType)
        guard heartRateStatus == .sharingAuthorized else {
            completion([])
            return
        }
        
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sort]) { query, samples, error in
            guard let heartRateSamples = samples as? [HKQuantitySample] else {
                completion([])
                return
            }
            completion(heartRateSamples)
        }
        healthStore.execute(query)
    }
    
    func startHeartRateUpdates() {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let heartRateStatus = HKHelper.healthStore.authorizationStatus(for: heartRateType)
        guard heartRateStatus == .sharingAuthorized else {
            return
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            
            let endDate = Date()
            let startDate = endDate.addingTimeInterval(-30.0)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
            let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { query, results, error in
                guard let sample = results?.first as? HKQuantitySample else {
                    print("No heart rate data found")
                    return
                }
                
                let heartRateUnit = HKUnit(from: "count/min")
                let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
                
                print("Heart rate: \(heartRate)")
            }
            
            HKHelper.healthStore.execute(query)
        }
        
        RunLoop.current.add(timer, forMode: .common)
    }
}
