//
//  ContentView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var LM = LocationManager()
    
    var body: some View {
//        
        NavigationView {
            MapView(selectedAnnotation: $LM.selectedAnnotation)
        }
        .onAppear(perform: {
            LM.serviceAvailabilityCheck()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
