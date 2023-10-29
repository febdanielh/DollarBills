//
//  RouteSheet.swift
//  DollarBills
//
//  Created by Elvis Susanto on 06/10/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct routeSheet: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State var showStartConfirmation = false
    
    @State var showStopConfirmation = false
    
    @State var showFilterView = false
    
    @Binding var selectedAnnotation: AnnotationModel
    
    @Binding var directions: [String]
    
    @Binding var isRouteSelected: Bool
    
    @State var isStarted: Bool = false
    
    var distance: CLLocationDistance = 0
    
    var body: some View {
        
        VStack() {
            
            ScrollView {
                
                VStack() {
                    
                    HStack {
                        Text(selectedAnnotation.routeName)
                            .font(.title)
                            .bold()
                        Spacer()
                        Button {
                            isRouteSelected = false
                        } label: {
                            Image("close black")
                        }
                    }.padding([.top, .horizontal]).padding(.top)
                    
                    HStack (spacing: 20) {
                        
                        HStack{
                            Image("Flag 3")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            let totalDistance = vm.routes.reduce(0) { $0 + $1.distance }
                            let totalDistanceKM = totalDistance / 1000
                            
                            Text(String(format: "%.2f km", totalDistanceKM))
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Clock 3")
                                .resizable()
                                .frame(width: 20, height: 20)
//                                .fill(Color.black)
                            Text("40 min - 1 hr")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Running Shoes 3")
                                .resizable()
                                .frame(width: 20, height: 20)
//                                .fill(Color.black)
                            Text("Pavement")
                                .modifier(RouteInfo())
                        }
                        
                    }
                    .frame(width: 356, alignment: .leading)
                    .padding([.bottom])
                    
                    HStack {
                        let distance = vm.getUserDistance(latitude: selectedAnnotation.waypoints[0].coordinate.latitude, longitude: selectedAnnotation.waypoints[0].coordinate.longitude)
                        
                        Text("This route is \(distance, specifier: "%.2f") km from you.")
                        
                        if (vm.distance > 0.2) {
                            Button(action: {
                            }, label: {
                                Text("Get Direction")
                                    .bold()
                            })
                        }
                        
                    }
                    .frame(width: 356, alignment: .leading)
                    .padding(.bottom)
                    
                    Divider()
                        .padding([.bottom, .leading, .trailing])
                    
                    Button(action: {
                        showStartConfirmation = true
                        isStarted = true
                    }, label: {
                        Text("START RUNNING")
                            .bold()
                    })
                    .buttonStyle(ActiveBlackSheetButton())
                    .padding(.bottom)
                    .fullScreenCover(isPresented: $isStarted, content: {
                        CountdownView()
                    })
                    
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach (1 ..< 4) { i in
                                Image("\(selectedAnnotation.routeName)/\(i)")
                                    .resizable()
                                    .frame(width: 300, height: 160)
                            }
                        }
                    }
                    .padding([.bottom, .leading, .trailing])
                }
            }
        }
        .presentationDetents([.fraction(0.47)])
        .interactiveDismissDisabled(true)
        .presentationBackgroundInteraction(.enabled)
    }
}
