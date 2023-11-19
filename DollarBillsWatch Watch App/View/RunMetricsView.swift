//
//  RunViewPage3.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunMetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date(),
                                             isPaused: workoutManager.session?.state == .paused)) { context in
            VStack (spacing: 20) {
                Text(Measurement(value: workoutManager.distance, unit: UnitLength.meters)
                    .formatted(.measurement(width: .abbreviated, usage: .road)))
                    .font(.title)
                    .fontWeight(.semibold)
                
                HStack {
                    Image (systemName: "heart.circle")
                        .foregroundColor(Color.pink)
                        .font(.title3)
                    Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))))
                    
                    Spacer()
                    
                    ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0)
                }
                .fontWeight(.semibold)
                
                HStack {
                    VStack (spacing: 5) {
                        Text("00'00\"")
                            .fontWeight(.semibold)
                        Text("Pace")
                    }
                    Spacer()
                    VStack (spacing: 5) {
                        Text(Measurement(value: workoutManager.activeEnergy, unit: UnitEnergy.kilocalories).formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                            .fontWeight(.semibold)
                        Text("Calories")
                    }
                }
            }
            .padding(.horizontal)
            .font(.title3)
        }
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool

    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
//#Preview {
//    RunMetricsView()
//}
