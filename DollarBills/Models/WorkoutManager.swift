//
//  WorkoutManager.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 23/10/23.
//

import Foundation
import HealthKit

@MainActor
class WorkoutManager: NSObject, ObservableObject {
    struct sessionStateChange {
        let newState: HKWorkoutSessionState
        let date: Date
    }
    
    @Published var sessionState: HKWorkoutSessionState = .notStarted
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var pace: Double = 0
    @Published var distance: Double = 0
    @Published var elapsedTimeInterval: TimeInterval = 0
    
    @Published var workout: HKWorkout?

    let typesToShare: Set = [HKQuantityType.workoutType()]
    
    let typesToRead: Set = [
        HKQuantityType(.heartRate),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType.workoutType(),
        HKObjectType.activitySummaryType()
    ]
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    #if os(watchOS)
    
    var builder: HKLiveWorkoutBuilder?
    #else

    var contextDate: Date?
    #endif
    
    let asynStreamTuple = AsyncStream.makeStream(of: sessionStateChange.self, bufferingPolicy: .bufferingNewest(1))
    
    static let workoutManager = WorkoutManager()
    
    private override init() {
        super.init()
        Task {
            for await value in asynStreamTuple.stream {
                await consumeSessionStateChange(value)
            }
        }
    }

    private func consumeSessionStateChange(_ change: sessionStateChange) async {
        sessionState = change.newState

        #if os(watchOS)

        let elapsedTimeInterval = session?.associatedWorkoutBuilder().elapsedTime(at: change.date) ?? 0
        let elapsedTime = WorkoutElapsedTime(timeInterval: elapsedTimeInterval, date: change.date)
        if let elapsedTimeData = try? JSONEncoder().encode(elapsedTime) {
            await sendData(elapsedTimeData)
        }
        
        guard change.newState == .stopped, let builder else {
            return
        }
        
        let finishedWorkout: HKWorkout?
        do {
            try await builder.endCollection(at: change.date)
            finishedWorkout = try await builder.finishWorkout()
            session?.end()
        } catch {
            print("Failed to end workout: \(error))")
            return
        }
        workout = finishedWorkout
        #endif
    }
}

// MARK: - Workout session management
//
extension WorkoutManager {
    func resetWorkout() {
        #if os(watchOS)
        builder = nil
        #endif
        workout = nil
        session = nil
        activeEnergy = 0
        heartRate = 0
        distance = 0
        sessionState = .notStarted
    }
    
    func sendData(_ data: Data) async {
        do {
            try await session?.sendToRemoteWorkoutSession(data: data)
        } catch {
            print("Failed to send data: \(error)")
        }
    }
}
// MARK: - Workout statistics
//
extension WorkoutManager {
    func updateForStatistics(_ statistics: HKStatistics) {
        switch statistics.quantityType {
        case HKQuantityType.quantityType(forIdentifier: .heartRate):
            let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
            heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            
        case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
            let energyUnit = HKUnit.kilocalorie()
            activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            
        case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning),
            HKQuantityType.quantityType(forIdentifier: .distanceCycling):
            let meterUnit = HKUnit.meter()
            distance = statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0
            
        default:
            return
        }
    }
}

// MARK: - A structure for synchronizing the elapsed time.
//
struct WorkoutElapsedTime: Codable {
    var timeInterval: TimeInterval
    var date: Date
}

// MARK: - Convenient workout state
//
extension HKWorkoutSessionState {
    var isActive: Bool {
        self != .notStarted && self != .ended
    }
}
