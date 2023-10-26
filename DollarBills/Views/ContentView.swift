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
    
    var body: some View {
        switch vm.currentDisplayScreen {
        case .viewOnboard:
            OnboardingView()
        case .viewMain:
            MainView(tag: $vm.tag, isRouteSelected: $vm.isRouteSelected)
                .onAppear {
                    removeAll()
                }
        case .viewMap:
            MapView(selectedAnnotation: $vm.selectedAnnotation, directions: $directions, tag: $vm.tag, isRouteSelected: $vm.isRouteSelected)
                .onAppear {
                    vm.serviceAvailabilityCheck()
                }
        case .viewRun:
            RunView(workout: vm.newWorkout)
        case .viewPause:
            PauseRunView(workout: vm.newWorkout, directions: $directions)
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
