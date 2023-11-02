//
//  PauseRunView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 12/10/23.
//

import SwiftUI

struct PauseRunView: View {
    let workout: Workout

    @EnvironmentObject var vm: ViewModel
    @Binding var directions: [String]
    @State private var isPaused = false
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 40){
            createMap(
                directions: $directions,
                routes: $vm.routes,
                selectedAnnotation: $vm.selectedAnnotation,
                cachedDirections: $vm.cachedDirections
            )
            .ignoresSafeArea()
            .frame(height: 400)
            .shadow(radius: 5)
            
            HStack(){
                Spacer()
                VStack(spacing: 20){
                    Text(String(workout.heartRate))
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("BPM")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedDuration())
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("Duration")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedPace())
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("Pace")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            HStack(){
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedDistance())
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("Distance")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedElevation())
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("Elevation")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack(spacing: 20){
                    Text(String(workout.calorieBurned))
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    Text("Calories")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            Spacer()
            HStack(spacing: 40){
                Button(action: {
                    print("stop pressed")
                    showAlert = true
                }, label: {
                    Image(systemName: "stop.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.YellowNormal)
                        .alert("Finish?", isPresented: $showAlert) {
                            Button("Yes") {}
                                .onTapGesture {
                                    Task {
                                        await vm.endWorkout()
                                    }
                                }
                            Button("No", role: .cancel) {}
                                .onTapGesture {
                                    Task {
                                        vm.discardWorkout()
                                    }
                                }
                        } message: {
                            Text("Are you sure you are finished? You cannot come back to this later")
                        }
                })

                Button(action: {
                    print("play pressed")
                }, label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.YellowNormal)
                        .onTapGesture {
                            isPaused.toggle()
                            if !isPaused {
                                Task {
                                    await vm.resumeWorkout()
                                    vm.currentDisplayScreen = .viewRun
                                }
                            }
                        }
                })
            }
            Spacer().frame(height: 45)
        }
    }
}

//#Preview {
//    PauseRunView(workout: workout, directions: .constant([]))
//}
