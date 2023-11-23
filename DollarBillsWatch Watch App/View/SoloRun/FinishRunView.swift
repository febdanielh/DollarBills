//
//  FinishRunView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct FinishRunView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var watchToPhone : WatchToPhone
    var body: some View {
        VStack {
            HStack{
                Text("Are You Sure?")
            }
            
            NavigationLink {
                InformationView()
                    .onAppear(perform: {
                        workoutManager.endWorkout()
                        watchToPhone.sendFinishWorkoutMessageToWatch()
                    })
                    .navigationBarBackButtonHidden(true)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 175, height: 50)
                        .foregroundStyle(Color.red)
                    Text("Finish Run")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .frame(width: 175, height: 50)
            .padding(.top, 8)
            
            
            NavigationLink {
                LandingPageView(routes: RouteData.routeData)
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        workoutManager.endWorkout()
                    }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 175, height: 50)
                        .foregroundStyle(Color.yellow)
                    Text("New Run")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .frame(width: 175, height: 50)
            .padding(.top, 8)
        }
    }
}

#Preview {
    FinishRunView()
}
