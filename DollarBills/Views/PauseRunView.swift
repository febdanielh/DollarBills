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
                        .bold()
                    Text("BPM")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedDuration())
                        .font(.system(size: 20))
                        .bold()
                    Text("Duration")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedPace())
                        .font(.system(size: 20))
                        .bold()
                    Text("Pace")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
            }
            HStack(){
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedDistance())
                        .font(.system(size: 20))
                        .bold()
                    Text("Distance")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text(workout.formattedElevation())
                        .font(.system(size: 20))
                        .bold()
                    Text("Elevation")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text(String(workout.calorieBurned))
                        .font(.system(size: 20))
                        .bold()
                    Text("Calories")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
            }
            Spacer()
            HStack(spacing: 40){
                Button(action: {
                    print("stop pressed")
                }, label: {
                    Image(systemName: "stop.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.YellowNormal)
                })
                
                Button(action: {
                    print("play pressed")
                }, label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.YellowNormal)
                })
            }
            Spacer()
        }
    }
}

//#Preview {
//    PauseRunView(workout: workout, directions: .constant([]))
//}
