//
//  ContentView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 26/09/23.
//

import SwiftUI
import CoreData
import MapKit

struct ExploreView: View {
    
    @EnvironmentObject var vm : ViewModel
    @State var selectedStatement = 0
    @State var routeSearching = ""
    @State private var isEditing = false
    @Binding var tag: Int
    @Binding var isRouteSelected: Bool
    
    var body: some View {
        NavigationView(content: {
            VStack {
                
                // GM & Race
                HStack {
                    
                    Text("Good Morning!")
                        .font(.system(size: 15))
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        
                        HStack (spacing: -4) {
                            
                            Text("User ID")
                                .frame(width: 102, height: 2)
                                .font(.system(size: 14))
                                .padding([.top, .bottom])
                                .foregroundColor(Color.YellowDark4)
                        }
                        .padding([.leading, .trailing])
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.YellowNormal, lineWidth: 2)
                        )
                        .background(Color.YellowLight3) // If you have this
                        .cornerRadius(15)
                        
                    })
                    
                }
                .padding(.leading)
                .frame(width: 356)
                
                // Search Bar
                TextField("Search for places or running routes", text: $routeSearching)
                    .font(.body)
                    .padding(7)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(30)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .padding([.top, .bottom])
                    .frame(width: 356)
                
                Divider()
                
                ScrollView {
                    
                    VStack {
                        RoutesOfTheWeek(isRouteSelected: $isRouteSelected)
                        
                        NearestRouteCard(vm: _vm, tag: $tag)
                        
                        QokkaPickCard(vm: _vm, tag: $tag)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .scrollIndicators(.hidden)
            }
        })
    }
    
}

#Preview {
    ExploreView(tag: .constant(0), isRouteSelected: .constant(false))
        .environmentObject(ViewModel())
}
