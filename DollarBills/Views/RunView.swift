//
//  RunView.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 12/10/23.
//

import SwiftUI

struct RunView: View {
    
    let workout: Workout
    
    var progressValue: Double {
        return workout.distance / 500.0
    }
    
    @State private var isPaused = false
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("- -")
                    Text("BPM")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack {
                    Text(workout.formattedDuration())
                    Text("Duration")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack {
                    Text(workout.formattedPace())
                    Text("Pace")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
            }
            .padding(.vertical, 30)
            Text(workout.formattedDistance())
                .font(.system(size: 28).weight(.bold))
                .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.48))
            Image("Quokka")
//            ProgressView(value: 0.2, label: { Text("Your Progress") }, currentValueLabel: { Text("20%") })
//                .progressViewStyle(BarProgressStyle(height: 25.0))
            
            ProgressView(value: progressValue, label: { Text("Your Progress") }, currentValueLabel: { Text("\(Int(progressValue * 100))%") })
                .progressViewStyle(BarProgressStyle(height: 25.0))
            
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.top, 80)
                .foregroundStyle(Color(red: 1, green: 0.87, blue: 0.2))
                .onTapGesture {
                    isPaused.toggle()
                    if isPaused {
                        vm.pauseWorkout()
                    }
                }

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    RunView()
//}
