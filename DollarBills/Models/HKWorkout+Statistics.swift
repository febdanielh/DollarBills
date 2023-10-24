//
//  HKWorkout+Statistics.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 23/10/23.
//

import Foundation
import HealthKit

extension HKWorkout {
    var elapsedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? ""
    }
    
//    var averageRunningPace: String {
//        var value: Double = 0
//        
//        let paceUnit = HKUnit.minute().unitDivided(by: HKUnit.meter())
//        
//        if let statistics = statistics(for: HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!),
//           let sum = statistics.sumQuantity(),
//           sum.doubleValue(for: HKUnit.meter()) > 0
//        {
//            value = sum.doubleValue(for: paceUnit) / duration
//        }
//        
//        let measurement = Measurement(value: value, unit: paceUnit)
//        let numberStyle = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(2)) // You may adjust precision as needed
//        return measurement.formatted(.measurement(width: .abbreviated, usage: .roa, numberFormatStyle: numberStyle))
//    }
    
    var totalRunningDistance: String {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.distanceWalkingRunning)),
           let sum = statistics.sumQuantity() {
            value = sum.doubleValue(for: .meter())
        }
        let measurement = Measurement(value: value, unit: UnitLength.meters)
        let numberStyle: FloatingPointFormatStyle<Double> = .number.precision(.fractionLength(2))
        return measurement.formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: numberStyle))
    }
    
    var totalCalorieBurned: Double {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.activeEnergyBurned)),
           let sum = statistics.sumQuantity() {
            value = sum.doubleValue(for: .kilocalorie())
        }
//        let measurement = Measurement(value: value, unit: UnitEnergy.kilocalories)
//        let numberStyle = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(0))
//        return measurement.formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: numberStyle))
        return value
    }
    
    var averageHeartRate: String {
        var value: Double = 0
        if let statistics = statistics(for: HKQuantityType(.heartRate)),
           let average = statistics.averageQuantity() {
            let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
            value = average.doubleValue(for: heartRateUnit)
        }
        return value.formatted(.number.precision(.fractionLength(0))) + " bpm"
    }

}
