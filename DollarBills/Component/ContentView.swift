//
//  ContentView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var LM = LocationManager()
    @Environment(\.scenePhase) var scenePhase
    @StateObject var vm = ViewModelWorkout()
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    var body: some View {
        NavigationView {
            MapView(
                selectedAnnotation: $LM.selectedAnnotation)
        }
        .onAppear(perform: {
            LM.locationAuthorizationCheck()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
