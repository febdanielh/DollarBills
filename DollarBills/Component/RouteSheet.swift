//
//  RouteSheet.swift
//  DollarBills
//
//  Created by Elvis Susanto on 06/10/23.
//

import Foundation
import SwiftUI

struct routeSheet: View {
    
    @EnvironmentObject var vm: ViewModel
    @State var showStartConfirmation = false
    @State var showFilterView = false
    @Binding var selectedAnnotation: AnnotationModel
    @Binding var directions: [String]
    @Binding var isSelected: Bool
    @State var isStarted: Bool = false
    
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
                            isSelected = false
                        } label: {
                            Image("close button yellow")
                        }
                    }.padding([.top, .horizontal]).padding(.top)
                    
                    HStack (spacing: 20) {
                        
                        HStack{
                            Image("Flag 2")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("5 km")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Clock 2")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("40 min - 1 hr")
                                .modifier(RouteInfo())
                        }
                        
                        HStack{
                            Image("Running Shoes 2")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Pavement")
                                .modifier(RouteInfo())
                        }
                        
                    }
                    .frame(width: 356, alignment: .leading)
                    .padding([.bottom])
                    
                    HStack {
                        Text("This route is \(vm.distance, specifier: "%.1f")km from you.")
                        
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
//                    .buttonStyle(ActiveBlackSheetButton())
                    .padding(.bottom)
                    .fullScreenCover(isPresented: $isStarted, content: {
//                        CountdownView()
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
        .presentationDetents([.fraction(0.48)])
        .presentationBackgroundInteraction(.disabled)
        .interactiveDismissDisabled(true)
    }
}
