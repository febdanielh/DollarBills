//
//  RouteSheet.swift
//  DollarBills
//
//  Created by Elvis Susanto on 06/10/23.
//

import Foundation
import SwiftUI

struct routeSheet: View {
    
    @ObservedObject var locationManager: LocationManager
    
    @Binding var selectedAnnotation: AnnotationModel?
    
    @Binding var directions: [String]
    
    var body: some View {
        
        VStack() {
            
            ScrollView {
                
                VStack() {
                    
                    Text(selectedAnnotation!.routeName)
                        .modifier(RouteTitle())
                    
                    HStack (spacing: 20) {
                        
                        HStack{
                            Image("Flag")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("5 km")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Clock")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("40 min - 1 hr")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Running Shoes")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Pavement")
                                .modifier(RouteInfo())
                        }
                        
                    }
                    .frame(width: 356, alignment: .leading)
                    .padding([.leading, .bottom])
                    
                    HStack {
                        Text("This route is \(locationManager.distance ?? 0.0, specifier: "%.1f")km from you.")
                        
                        if (locationManager.distance != nil && locationManager.distance! > 0.2) {
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
                        
                    }, label: {
                        Text("START RUNNING")
                            .bold()
                    })
                    .buttonStyle(FillButton())
                    .padding(.bottom)
                    
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach (1 ..< 4) { i in
                                Image("\(selectedAnnotation!.routeName)/\(i)")
                                    .resizable()
                                    .frame(width: 300, height: 160)
                            }
                        }
                    }
                    .padding([.bottom, .leading, .trailing])
                    
                }
                
            }
            
//            List{
//                ForEach(directions.indices, id: \.self) { i in
//                    Text(directions[i])
//                        .padding()
//                }
//            }
            
        }
        .presentationDetents([.medium])
        .presentationBackgroundInteraction(.disabled)
        .interactiveDismissDisabled(false)
        
    }
}
