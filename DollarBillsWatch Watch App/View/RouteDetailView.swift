//
//  RouteDetailView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct RouteDetailView: View {
    var body: some View {
        
        ScrollView {
            VStack{
                MapView()
                    .frame(height: 170)
                RouteSheet()
            }
            
                
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RouteDetailView()
}
