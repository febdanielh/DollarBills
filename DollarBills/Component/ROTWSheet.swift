//
//  ROTWSheet.swift
//  DollarBills
//
//  Created by Febrian Daniel on 08/11/23.
//

import SwiftUI
import CoreLocation

struct ROTWSheet: View {
    @EnvironmentObject var vm: ViewModel
    @State var showStartConfirmation = false
    @State var showStopConfirmation = false
    @State var showFilterView = false
    @Binding var selectedAnnotation: AnnotationModel
    @Binding var directions: [String]
    
    @Binding var isRouteSelected: Bool
    @State var isStarted: Bool = false
    @Binding var currentRouteIndex: Int
    
    @State var distance: CLLocationDistance = 0
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(selectedAnnotation.routeName)
                            .font(.system(size: 30))
                            .bold()
                        Spacer()
                        Button {
                            vm.currentDisplayScreen = .viewMain
                            isRouteSelected = false
                        } label: {
                            Image("close black")
                        }
                    }.padding(.top)
                    
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
                            Text("40 min - 1 hr")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Running Shoes 3")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Pavement")
                                .modifier(RouteInfo())
                        }
                        
                    }
                    .frame(width: 356, alignment: .leading)
                    .padding([.bottom])
                    
                    HStack {
                        
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
                    
                    Text("Elevation")
                        .font(.system(size: 14)).fontWeight(.medium)
                        .padding(.vertical)
                    
                    Divider().padding(.vertical)
                    
                    Button(action: {
                        showStartConfirmation = true
                        isStarted = true
                    }, label: {
                        Text("START RUNNING")
                            .bold()
                    })
                    .onTapGesture {
                        Task {
                            await vm.startWorkout(type: .running)
                        }
                    }
                    .frame(maxWidth: .infinity)
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
                }.padding(.vertical).padding(.horizontal, 24)
            }
        }
        .onAppear{
            distance = vm.getUserDistance(latitude: selectedAnnotation.waypoints[0].coordinate.latitude , longitude: selectedAnnotation.waypoints[0].coordinate.longitude)
        }
        .presentationDetents([.fraction(0.47), .medium])
        .interactiveDismissDisabled(true)
        .presentationBackgroundInteraction(.enabled)
        
    }
}
