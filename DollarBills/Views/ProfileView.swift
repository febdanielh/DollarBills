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
    
    var body: some View {
        
        VStack {
            
            Text("Profile")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            
            ScrollView {
                
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
                            .foregroundStyle(Color.YellowDark)
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
                        .padding(.leading)
                    Image(systemName: "pencil.line")
                    Spacer()
                }
                .padding()
                
                TextField( username, text: $username)
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
                    
                    Button(action: {
                        
                    }, label: {
                        Text("See All >")
                            .font(.callout)
                            .foregroundStyle(Color.TextDimGray)
                    })
                    
                    
                }
                .padding([.leading,.trailing])
                
                Text("5/30")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
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
                                } else {
                                    Image("\(i)Rock")
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
                
            }
            .frame(width: 380)
            .scrollIndicators(.hidden)
            
        }
        
    }
    
}

#Preview {
    ProfileView()
}
