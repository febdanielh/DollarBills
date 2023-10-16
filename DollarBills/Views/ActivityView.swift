//
//  ContentView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 26/09/23.
//

import SwiftUI
import CoreData
import MapKit

struct ActivityView: View {
    
    @EnvironmentObject var VM : ViewModel
    
    var body: some View {
        
        ScrollView {
            
            Text("Activity View")
            
        }
        .scrollIndicators(.hidden)
        
    }
    
}
