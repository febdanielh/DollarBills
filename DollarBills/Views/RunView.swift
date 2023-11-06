//
//  RunView.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 12/10/23.
//

import SwiftUI

struct RunView: View {
    
    let workout: Workout
    
    @EnvironmentObject var vm: ViewModel
    
    @State var runImage: String = "spruto lari"
    @State var runDescription: String = "Run and collect items"
    
    @Binding var itemCollected: [Items]
    
    @State var isGif: Bool = true
    @State var isPaused: Bool = false
    @State var showAlert: Bool = false
    
    var progressValue: Double {
        return workout.distance / 500.0
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack (alignment: .leading, spacing: 30){
                HStack(spacing: 17) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 200)
                            .fill(Color(red: 1, green: 0.54, blue: 0))
                            .frame(width: 59, height: 20)
                        Text("Target")
                            .font(.system(size: 13)).fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    Text(workout.formattedDistance())
                        .font(.system(size: 25).weight(.bold))
                        .foregroundColor(Color(red: 0.18, green: 0.19, blue: 0.2))
                    
                }.padding(.bottom, 20)
                
                HStack {
                    VStack(spacing: 17) {
                        Text("- -")
                            .font(.title3).fontWeight(.black)
                        Text("BPM")
                            .font(.body).fontWeight(.medium)
                    }
                    Spacer()
                    VStack(spacing: 17) {
                        Text(workout.formattedDuration())
                            .font(.title3).fontWeight(.black)
                        Text("Duration")
                            .font(.body).fontWeight(.medium)
                    }
                    Spacer()
                    VStack(spacing: 17) {
                        Text(workout.formattedPace())
                            .font(.title3).fontWeight(.black)
                        Text("Pace")
                            .font(.body).fontWeight(.medium)
                    }
                }
            }
            
            VStack {
                if isGif {
                    GifImage(name: runImage)
                        .frame(width: 220, height: 220)
                        .padding()
                } else {
                    ZStack {
                        Image(runImage)
                            .resizable()
                            .frame(width: 300, height: 210)
                            .padding()
                    }
                }
            }.onReceive(vm.$itemsCollected, perform: { items in
                if let lastItem = items.last {
                    runImage = lastItem.image
                    runDescription = "You obtain a \(lastItem.namaItem). Finish the route to claim it"
                    isGif = false
                }
                Haptics.instance.simpleSuccess(type: .success)
            })
            
            Text(runDescription)
                .font(.body)
                .multilineTextAlignment(.center)
                .italic()
                .foregroundColor(Color.TextDimGray)
                .padding(.horizontal, 10)
                .padding(.bottom)
            
            let totalDistance = vm.routes.reduce(0) { $0 + $1.distance }
            var progressValue: Double {
                return workout.distance / totalDistance
            }
            
            ProgressView(value: progressValue, label: { Text("Your Progress") }, currentValueLabel: { Text("\(Int(progressValue * 100))%") })
                .progressViewStyle(BarProgressStyle(height: 25.0))
                .padding(.top)
            
            HStack(spacing: 30){
                Image(systemName: "stop.circle.fill")
                    .resizable()
                    .frame(width: 80.56, height: 80.56)
                    .foregroundColor(.redStopButton)
                    .onTapGesture {
                        print("stop pressed")
                        showAlert = true
                    }
                    .alert("Finish?", isPresented: $showAlert) {
                        Button("Yes") {
                            Task {
                                await vm.endWorkout()
                            }
                            vm.currentDisplayScreen = .viewMain
                        }
                        Button("No", role: .cancel) {
                            Task {
                                vm.discardWorkout()
                            }
                            vm.currentDisplayScreen = .viewMain
                        }
                    } message: {
                        Text("Are you sure you are finished? You cannot come back to this later")
                    }
                
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .frame(width: 80.56, height: 80.56)
                    .foregroundStyle(Color.YellowNormal2)
                    .onTapGesture {
                        isPaused.toggle()
                        if isPaused {
                            Task {
                                await vm.pauseWorkout()
                                vm.currentDisplayScreen = .viewPause
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}

#Preview {
    ProgressView(value: 0.5, label: { Text("Your Progress") }, currentValueLabel: { Text("\(Int(0.5 * 100))%") })
        .progressViewStyle(BarProgressStyle(height: 25.0))
}
