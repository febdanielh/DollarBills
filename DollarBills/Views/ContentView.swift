//
//  ContentView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

enum DisplayScreen {
    case viewOnboard
    case viewIsi
}

struct ContentView: View {
    @State var currentDisplayScreen: DisplayScreen = .viewOnboard
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    var body: some View {
        switch currentDisplayScreen {
        case .viewOnboard:
            OnboardingView(currentDisplayScreen: $currentDisplayScreen)
        case .viewIsi:
            MapView(selectedAnnotation: $vm.selectedAnnotation)
                .onAppear{
                    vm.serviceAvailabilityCheck()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
