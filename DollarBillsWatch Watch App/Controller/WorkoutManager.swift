//
//  WorkoutManager.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 08/11/23.
//

import Foundation
import HealthKit
import SwiftUI
import WatchConnectivity

class WorkoutManager: NSObject, ObservableObject {
    let workoutType: HKWorkoutActivityType = .running
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    var watchSession: WCSession?
    var routeBuilder: HKWorkoutRouteBuilder?
    
    var locationManager = LocationManager()
    @Published var currentDisplayScreen: DisplayScreen = .viewHome
    
    init(watchSession: WCSession) {
        self.watchSession = watchSession
        super.init()
        self.watchSession?.delegate = self
    }
    
    func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        let startDate = Date()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            return
        }
        
        session?.delegate = self
        builder?.delegate = self
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                      workoutConfiguration: configuration)
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
        }
        
    }
    
    
    func requestAuthorization() {
        let typesToShare: Set = [
            HKQuantityType.workoutType(),
            HKSeriesType.workoutRoute()
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.workoutType(),
            HKSeriesType.workoutRoute(),
            HKObjectType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
        }
    }
    
    func finishRoute(to workout: HKWorkout?) {
        guard let workout = workout else {
            print("No workout to associate with the route.")
            return
        }
        
        routeBuilder?.finishRoute(with: workout, metadata: nil, completion: { (route, error) in
            if let error = error {
                print("Error finishing route: \(error.localizedDescription)")
            } else {
                print("Route finished successfully.")
            }
        })
    }
    
    // MARK: - Session State Control
    
    @Published var running = false
    
    func togglePause() {
        if running == true {
            self.pause()
        } else {
            resume()
        }
    }
    
    func pause() {
        session?.pause()
    }
    
    func resume() {
        session?.resume()
    }
    
    func endWorkout() {
        session?.end()
        
        //        builder?.endCollection(withEnd: Date()) { [weak self] (success, error) in
        //            self?.builder?.finishWorkout { (workout, error) in
        //                DispatchQueue.main.async {
        //                    self?.workout = workout
        //                    self?.finishRoute(to: workout)
        //                }
        //            }
        //        }
    }
    
    // MARK: - Workout Metrics
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var distance: Double = 0
    @Published var pace: Double = 0
    @Published var elevation: Double = 0
    @Published var workout: HKWorkout?
    
    
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }
        
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
                
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning):
                let meterUnit = HKUnit.meter()
                self.distance = statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0
                
            case HKQuantityType.quantityType(forIdentifier: .flightsClimbed):
                let elevationUnit = HKUnit.meter()
                self.elevation = statistics.sumQuantity()?.doubleValue(for: elevationUnit) ?? 0
            default:
                return
            }
        }
    }
    
    func resetWorkout() {
        builder = nil
        workout = nil
        session = nil
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
        distance = 0
        pace = 0
        elevation = 0
    }
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        
        if toState == .ended {
            builder?.endCollection(withEnd: date) { [weak self] (success, error) in
                self?.builder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async {
                        self?.workout = workout
                        self?.finishRoute(to: workout)
                    }
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            updateForStatistics(statistics)
        }
    }
}

// MARK: - WCSessionDelegate
extension WorkoutManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("The session activation is failed with error: \(error.localizedDescription)")
        } else {
            print("The session has completed activation on Watch.")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let value = message["Message"] as? String {
            print("message received")
            if (value == "Start Workout") {
                currentDisplayScreen = .viewRun
            } else if (value == "Start Match") {
                currentDisplayScreen = .viewDuel
            }
        }
    }
}
