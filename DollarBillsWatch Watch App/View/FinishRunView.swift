//
//  FinishRunView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct FinishRunView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var body: some View {
        VStack {
            HStack{
                Text("Are You Sure?")
            }
            
            
            NavigationLink {
                InformationView()
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
            .padding(.top, 8)
            .onTapGesture {
                workoutManager.endWorkout()
            }
            
            NavigationLink {
                LandingPageView()
                    .navigationBarBackButtonHidden(true)
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
            .onTapGesture {
                workoutManager.endWorkout()
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    FinishRunView()
}
