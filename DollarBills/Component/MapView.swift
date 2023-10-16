//
//  MapView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import SwiftUI

struct MapView: View {
    
//    @ObservedObject var locationManager = LocationManager()
    
    @State var directions: [String] = []
    
    @State var showDirections: Bool = false
    
    @Binding var selectedAnnotation: AnnotationModel?
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    var body: some View {
        
        VStack {
            ZStack {
                
            createMap(
                
                directions: $directions,
                selectedAnnotation: $selectedAnnotation,
                showDirections: $showDirections
                
            )
                
            .ignoresSafeArea()
            VStack(spacing: 10) {
                Spacer()
                if let workout = vm.selectedWorkout {
                    WorkoutBar(workout: workout, new: false)
                }
//                WorkoutMenuView()
                if vm.recording {
                    WorkoutBar(workout: vm.newWorkout, new: true)
                }
            }
            .padding(10)
        }
        .animation(.default, value: vm.recording)
        .animation(.default, value: vm.selectedWorkout)
        .alert(vm.error.rawValue, isPresented: $vm.showErrorAlert) {} message: {
            Text(vm.error.message)
        }
        .onAppear {
            if !launchedBefore {
                launchedBefore = true
                welcome = true
                vm.showInfoView = true
                vm.showAccountView = false

            }
        }
        .fullScreenCover(isPresented: $vm.healthUnavailable) {
            ErrorView(systemName: "heart.slash", title: "Health Unavailable", message: "\(NAME) needs access to the Health App to store and load workouts. Unfortunately, this device does not have these capabilities so the app will not work.")
        }

        .sheet(isPresented: $vm.showPermissionsView) {
            PermissionsView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                vm.updateHealthStatus()
            }
        }
        .environmentObject(vm)
            
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("Show Directions")
            })
            .disabled(directions.isEmpty)
            .padding()
        }
        .sheet (
            isPresented: $showDirections,
            content: { routeSheet(selectedAnnotation: $selectedAnnotation, directions: $directions).environmentObject(vm) }
        )
        
    }
    
}
