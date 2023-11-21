//
//  File.swift
//  DollarBills
//
//  Created by Elvis Susanto on 19/10/23.
//

import Foundation
import SwiftUI
import CoreData
import MapKit

struct ProfileView: View {
    
    @EnvironmentObject var VM : ViewModel
    
    @State var username = "Nicolas Amory Gaming"
    
    @State var watchIsOn = false
    
    @State var notificationIsOn = false
    
    @State var audioIsOn = false
    
    @State var energyIsOn = false
    
    @State var heartIsOn = false
    
    @State var routesIsOn = false
    
    @State var workoutIsOn = false
    
    var body: some View {
        
        NavigationView(content: {
            
            VStack {
                HStack{
                    Text("Profile")
                        .font(.system(size: 30))
                        .bold()
                        .padding([.top, .horizontal])
                    Spacer()
                }
                Divider()
                ScrollView {
                    
                    // Everything Above Spruto Ijo
                    ZStack {
                        
                        UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 20)
                            .frame(width: 390, height: 500)
                            .foregroundStyle(.white)
                            .background(Color.WPBG)
                            .ignoresSafeArea()
                        
                        VStack {
                            
                            HStack {
                                
                                Text("Rank #23")
                                    .padding()
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                                    .frame(height: 26, alignment: .center)
                                    .background(
                                        Color.YellowNormal)
                                    .cornerRadius(16.0)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 16.0)
                                            .stroke(Color.YellowNormal, lineWidth: 0)
                                    )
                                
                                HStack (spacing: 2) {
                                    
                                    Text("●")
                                        .foregroundStyle(Color.YellowDark4)
                                    Text("15000")
                                    
                                }
                                .padding()
                                .font(.system(size: 13))
                                .foregroundStyle(Color.black)
                                .frame(height: 26, alignment: .center)
                                .background(
                                    Color.YellowNormal)
                                .cornerRadius(16.0)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 16.0)
                                        .stroke(Color.YellowNormal, lineWidth: 0)
                                )
                                
                                Spacer()
                                
                            }
                            .padding()
                            
                            HStack {
                                Text("User ID")
                                    .font(.system(size: 15)).fontWeight(.semibold)
                                    .padding(.leading)
                                Image(systemName: "pencil.line")
                                Spacer()
                            }
                            .padding()
                            
                            TextField(username, text: $username)
                                .foregroundStyle(.gray)
                                .padding()
                                .frame(height: 46)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .padding([.leading, .trailing])
                            
                            Divider()
                                .padding()
                            
                            HStack {
                                
                                Text("Your Item")
                                    .foregroundStyle(.black)
                                    .font(.body)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                NavigationLink {
                                    ItemDetailView()
                                } label: {
                                    Text("See All >")
                                        .font(.callout)
                                        .foregroundStyle(Color.TextDimGray)
                                }
                                
                            }
                            .padding([.leading,.trailing])
                            
                            Text("5/30")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding()
                            
                            VStack {
                                
                                ProgressView(value: 0.17)
                                    .progressViewStyle(BarProgressStyleDuel())
                                    .padding()
                                
                                HStack {
                                    
                                    ForEach(0 ..< 4) { i in
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: 11)
                                                    .frame(width: 77, height: 80)
                                                    .foregroundStyle(Color.WPBG)
                                                
                                                if (i % 2 == 0) {
                                                    Image("\(i)Potion")
                                                        .resizable()
                                                        .frame(width: 80, height: 60)
                                                } else {
                                                    Image("\(i)Rock")
                                                        .resizable()
                                                        .frame(width: 80, height: 60)
                                                }
                                                
                                                VStack (alignment: .trailing) {
                                                    
                                                    Spacer()
                                                    
                                                    HStack {
                                                        
                                                        Spacer()
                                                        
                                                        ZStack {
                                                            
                                                            Image("x1")
                                                            Text("x1")
                                                                .foregroundStyle(.white)
                                                                .font(.caption)
                                                                .fontWeight(.semibold)
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                .frame(width: 77)
                                                
                                            }
                                        })
                                        
                                    }
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.bottom)
                            }
                            .frame(height: 150)
                            
                            Spacer()
                            
                        }
                        
                    }
                    
                    ZStack {
                        
                        Color.WPBG
                            .ignoresSafeArea()
                        
                        VStack {
                            
                            // Spruto Ijo
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 350, height: 380)
                                    .foregroundStyle(Color.YellowLight1)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 16.0)
                                            .stroke(Color.YellowLight2, lineWidth: 1)
                                    )
                                
                                VStack {
                                    
                                    Image("ButoIjo2")
                                    Text("Go Premium")
                                        .fontWeight(.semibold)
                                        .padding(.bottom)
                                    Text("Unlock more routes and features\nby going premium")
                                        .multilineTextAlignment(.center)
                                        .font(.body)
                                        .padding(.bottom)
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Start Free Trial")
                                    })
                                    .buttonStyle(ActiveBlackButtonProfile())
                                    
                                }
                                
                            }
                            .padding()
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $watchIsOn) {
                                    Text("Apple Watch")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .padding(.top)
                            .frame(width: 350)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $notificationIsOn) {
                                    Text("Notifications")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .frame(width: 350)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $audioIsOn) {
                                    Text("Audio")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .padding(.bottom)
                            .frame(width: 350)
                            
                            HStack {
                                Text("Apple Health")
                                    .foregroundStyle(Color.TextDimGray)
                                Spacer()
                            }
                            .frame(width: 320)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $energyIsOn) {
                                    Text("Active Energy")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .frame(width: 350)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $heartIsOn) {
                                    Text("Heart")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .frame(width: 350)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $routesIsOn) {
                                    Text("Workout Routes")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .frame(width: 350)
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                                    .frame(height: 58)
                                
                                
                                Toggle(isOn: $workoutIsOn) {
                                    Text("Workout")
                                }
                                .padding([.leading, .trailing])
                                
                            }
                            .padding(.bottom)
                            .frame(width: 350)
                            
                        }
                        
                    }
                    
                }
                .frame(width: 380)
                .scrollIndicators(.hidden)
                
            }
//            .navigationTitle("Profile")
            
        })
        .ignoresSafeArea()
        
    }
    
}

#Preview {
    ProfileView()
}
