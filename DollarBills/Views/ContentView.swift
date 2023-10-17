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
}

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    var body: some View {
        switch vm.currentDisplayScreen {
        case .viewOnboard:
            OnboardingView()
        case .viewMain:
            MainView()
        case .viewMap:
            MapView(selectedAnnotation: $vm.selectedAnnotation)
                .onAppear{
                    vm.serviceAvailabilityCheck()
                }
        case .viewRun:
            RunView(workout: vm.newWorkout)
        }
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
