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
    @Binding var tag: Int
    @Binding var isRouteSelected: Bool
    
    var body: some View {
                VStack {
                    
                    if (vm.selectedSegment == 0) {
                        ExploreView(tag: $tag, isRouteSelected: $isRouteSelected)
                    } else if (vm.selectedSegment == 1) {
                        ActivityView()
                    } else if (vm.selectedSegment == 2) {
                        DuelModeView()
                    } else if (vm.selectedSegment == 3) {
                        ProfileView()
                    }
                    
                }
                
                VStack {
                    
                    Spacer()
                    
                    SegmentTabView()
                    
                }
                .frame(height: 60)
    }
}

#Preview {
    ContentView().environmentObject(ViewModel())
}
