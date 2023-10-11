//
//  WorkoutMenu.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import SwiftUI
import MapKit
import HealthKit

struct WorkoutMenuView: View {
    @EnvironmentObject var vm: ViewModelWorkout
    @State var showStartConfirmation = false
    @State var showStopConfirmation = false
    @State var showFilterView = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            Button {
                vm.updateTrackingMode()
            } label: {
                Image(systemName: vm.trackingModeImage)
                    .frame(width: 50, height: 50)
                    .scaleEffect(vm.scale)
            }
            Divider().frame(height: 50)
            
            if vm.recording {
                Button {
                    showStopConfirmation = true
                } label: {
                    Image(systemName: "stop.fill")
                        .frame(width: 50, height: 50)
                }
                .confirmationDialog("Stop Workout?", isPresented: $showStopConfirmation, titleVisibility: .visible) {
                    Button("Cancel", role: .cancel) {}
                    Button("Stop & Discard", role: .destructive) {
                        vm.discardWorkout()
                    }
                    Button("Finish & Save") {
                        Task {
                            await vm.endWorkout()
                        }
                    }
                }
            } else {
                Button {
                    showStartConfirmation = true
                } label: {
                    Image(systemName: "record.circle")
                        .frame(width: 50, height: 50)
                }
                .confirmationDialog("Record a Workout", isPresented: $showStartConfirmation, titleVisibility: .visible) {
                    Button("Cancel", role: .cancel) {
                        // Handle cancellation
                    }
                    Button("Start Workout") {
                        Task {
                            await vm.startWorkout(type: .running)
                        }
                    }
                }

            }

            Divider().frame(height: 50)
            
            Menu {
                Picker("Date", selection: $vm.workoutDate) {
                    Text("All")
                        .tag(nil as WorkoutDate?)
                    ForEach(WorkoutDate.allCases.reversed(), id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type as WorkoutDate?)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Filter Workouts")
            }
            label: {
                if vm.loadingWorkouts {
                    ProgressView()
                        .frame(width: 50, height: 50)
                } else if !vm.workouts.isEmpty {
                    Image(systemName: "line.3.horizontal.decrease.circle" + (vm.workoutDate == nil ? "" : ".fill"))
                        .frame(width: 50, height: 50)
                }
            }
//            Divider().frame(height: SIZE)
            
        }
        
        
        .font(.system(size: 25))
        .materialBackground()
    }
    
}

struct WorkoutMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMenuView()
            .environmentObject(ViewModelWorkout())
    }
}
