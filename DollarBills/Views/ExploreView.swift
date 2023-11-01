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
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // GM & Race
                HStack {
                    Text("Explore")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                    }, label: {
                        HStack {
                            Text("User ID")
                                .frame(width: 125, height: 30)
                                .font(.system(size: 13)).fontWeight(.semibold)
                                .foregroundColor(Color.YellowDark4)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 200)
                                .stroke(Color.YellowDark4, lineWidth: 2)
                        )
                        .background(Color.YellowLight3)
                        .cornerRadius(200)
                    })
                }
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
                    .padding(.bottom)
                    .frame(width: 356)
                
                Divider()
                
                ScrollView {
                    ZStack {
                        Color.SheetGray
                            .ignoresSafeArea()
                        VStack(spacing: 20) {
                            Text("Routes of The Week")
                                .foregroundStyle(.black)
                                .font(.system(size: 20)).fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                                .frame(width: 361)
                            
                            SnapCarouselView(trailingSpace: 10, index: $currentIndex, items: vm.annotations) { routes in
                                    RoutesOfTheWeek(isRouteSelected: $isRouteSelected, routes: routes)
                            }
                            .padding(.bottom, 210)
                            
                            HStack(spacing: 6) {
                                ForEach(vm.annotations.indices, id: \.self) { index in
                                    RoundedRectangle(cornerRadius: currentIndex == index ? 24 : 100, style: .continuous)
                                        .fill(.black)
                                        .frame(width: currentIndex == index ? 13 : 5, height: 6)
                                        .opacity(currentIndex == index ? 1 : 0.2)
                                        .animation(.spring(), value: currentIndex == index )
                                }
                            }
                            
                            if CLLocationManager.authorizationStatus() == .notDetermined {
                                AllowLocationRect()
                            } else {
                                NearestRouteCard(vm: _vm, tag: $tag, routes: RouteData.routeData, selectedRoute: $vm.selectedRoute)
                            }
                            
                            QokkaPickCard(vm: _vm, tag: $tag, routes: RouteData.furthrPick, selectedRoute: $vm.selectedRoute)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("Explore")
        
    }
    
}

#Preview {
    ExploreView(tag: .constant(0), isRouteSelected: .constant(false))
        .environmentObject(ViewModel())
}
