//
//  ContentView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

enum DisplayScreen {
    case viewOnboard
    case viewMain
    case viewMap
    case viewROTWMap
    case viewRun
    case viewPause
}

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    @State var directions: [String] = []
    @State var shouldShowOnboarding = true
    
    var body: some View {
        if launchedBefore && networkMonitor.isConnected {
            switch vm.currentDisplayScreen {
            case .viewMain:
                MainView(tag: $vm.tag, isRouteSelected: $vm.isRouteSelected)
                    .onAppear {
                        vm.removeAll()
                        vm.selectedRoute = Routes(tag: 0, routeName: "", routeNameDetail: "", routeImage: "", routeCount: 0, latitude: 0.0, longitude: 0.0)
                        directions.removeAll()
                    }
            case .viewMap:
                MapView(selectedAnnotation: $vm.selectedAnnotation, directions: $directions, tag: $vm.tag, isRouteSelected: $vm.isRouteSelected, selectedRoute: $vm.selectedRoute)
                    .onAppear {
                        vm.serviceAvailabilityCheck()
                    }
            case .viewROTWMap:
                ROTWMapView(selectedAnnotation: $vm.selectedAnnotation, directions: $directions, isRouteSelected: $vm.isRouteSelected, selectedRoute: $vm.selectedRoute)
                    .onAppear {
                        vm.serviceAvailabilityCheck()
                    }
            case .viewRun:
                //                RunView(workout: vm.newWorkout, itemCollected: $vm.itemsCollected)
                RunWatchView(workout: vm.newWorkout, itemCollected: $vm.itemsCollected)
            case .viewPause:
                PauseRunView(workout: vm.newWorkout, directions: $directions)
            default:
                Text("Default View")
            }
        } else if (!vm.isAuthenticated || shouldShowOnboarding) && networkMonitor.isConnected {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                .onDisappear {
                    launchedBefore = true
                    vm.currentDisplayScreen = .viewMain
                }
        }
        else if !networkMonitor.isConnected {
            DisconnectedView()
        }
        
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
