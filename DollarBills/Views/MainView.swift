//
//  ContentView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 16/10/23.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        
        VStack {
            
            if (vm.selectedSegment == 0) {
                ExploreView().environmentObject(vm)
            } else if (vm.selectedSegment == 1) {
                ActivityView().environmentObject(vm)
            } else if (vm.selectedSegment == 2) {
                
            }
            
        }
        
        VStack {
            
            Spacer()
            
            SegmentTabView().environmentObject(vm)
            
        }
        .frame(height: 60)
        
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
