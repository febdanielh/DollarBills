//
//  RouteSheet.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct RouteSheet: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var watchToPhone = WatchToPhone()
    var routes: Routes
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 8) {
                Text(routes.routeName)
                    .font(.title2)
                HStack {
                    Image(systemName: "flag.checkered")
                    Text("5 km")
                }
                
                HStack {
                    Image(systemName: "clock.fill")
                    Text("40 min - 1h")
                }
                
                HStack {
                    Image(systemName: "shoeprints.fill")
                    Text("Pavement")
                }
                
                ZStack {
                    Rectangle()
                        .frame(height: 60)
                        .foregroundColor(Color.black)
                    
                    ElevationGraph()
                }
                .padding(.horizontal)
                
                
            }
            .padding(.horizontal)
            
            NavigationLink {
//                Countdown()
                RunViewTab()
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        if workoutManager.session?.state != .running {
                            workoutManager.startWorkout(workoutType: .running)
                        }
                    }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 155, height: 50)
                        .foregroundStyle(Color.yellow)
                    Text("Start Running")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .padding(.top, 8)
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

//#Preview {
//    RouteSheet()
//}
