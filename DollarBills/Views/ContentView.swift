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
    case viewRun
    case viewPause
}

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    @State var directions: [String] = []
    @State var shouldShowOnboarding = true
    
    var body: some View {
        if launchedBefore {
            switch vm.currentDisplayScreen {
            case .viewMain:
                MainView(tag: $vm.tag, isRouteSelected: $vm.isRouteSelected)
                    .onAppear {
                        removeAll()
                    }
            case .viewMap:
                MapView(selectedAnnotation: $vm.selectedAnnotation, directions: $directions, tag: $vm.tag, isRouteSelected: $vm.isRouteSelected, selectedRoute: $vm.selectedRoute)
                    .onAppear {
                        vm.serviceAvailabilityCheck()
                    }
            case .viewRun:
                RunView(workout: vm.newWorkout, itemCollected: $vm.itemCollected)
            case .viewPause:
                PauseRunView(directions: $directions)
            default:
                Text("Default View")
            }
        } else if shouldShowOnboarding {
            AnotherOnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                .onDisappear {
                    launchedBefore = true
                    vm.currentDisplayScreen = .viewMain
                }
        }
    }
    
    func removeAll() {
        vm.selectedAnnotation = AnnotationModel(routeName: "", waypoints: [])
        vm.mapView.removeOverlays((vm.mapView.overlays))
        vm.routes.removeAll()
        vm.cachedDirections.removeAll()
        directions.removeAll()
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
