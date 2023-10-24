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
    var body: some View {
        VStack(spacing: 40){
            MapView(selectedAnnotation: $vm.selectedAnnotation)
                .frame(width: 400, height: 400)
                .foregroundColor(Color.primaryColor01)
                .ignoresSafeArea()
                .shadow(radius: 8)
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
                        .foregroundColor(.primaryColor01)
                })
                
                Button(action: {
                    print("play pressed")
                }, label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.primaryColor01)
                })
            }
            Spacer()
        }
    }
}

//#Preview {
//    PauseRunView()
//}
