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
    
    @State private var authPath = 0
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Text("Insights")
                        .font(.title2)
                        .bold()
                        .padding()
                    Spacer()
                }
                
                ZStack {
                    
                    HStack (spacing: 20) {
                        
                        Button(action: {
                            authPath = 0
                        }, label: {
                            VStack {
                                Text("Summary")
                                    .foregroundStyle(.black)
                                    .bold()
                                if (authPath == 0) {
                                    ExDivider(width: 91)
                                } else {
                                    Spacer()
                                }
                            }
                        })
                        
                        Button(action: {
                            authPath = 1
                        }, label: {
                            VStack {
                                Text("Leaderboard")
                                    .foregroundStyle(.black)
                                    .bold()
                                if (authPath == 1) {
                                    ExDivider(width: 112)
                                } else {
                                    Spacer()
                                }
                            }
                        })
                        Spacer()
                        
                    }
                    .frame(height: 30)
                    .padding([.bottom, .leading])
                    
                    VStack {
                        Spacer()
                        Divider()
                    }
                    .frame(height: 15)
                    
                }
                
                
                if authPath == 0 {
                    SummaryView()
                        .transition(.move(edge:.leading))
                }
                if authPath == 1 {
                    LeaderboardView()
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

#Preview {
    ActivityView().environmentObject(ViewModel())
}
