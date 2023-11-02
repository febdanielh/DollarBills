//
//  DuelModeView.swift
//  DollarBills
//
//  Created by Elvis Susanto on 19/10/23.
//


import SwiftUI
import CoreData
import MapKit

struct DuelModeView: View {
    
    @EnvironmentObject var VM : ViewModel
    
    var body: some View {
        
        VStack {
            
            Text("Duel Mode")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            ScrollView {
                
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            
                            VStack (alignment: .leading) {
                                
                                Spacer()
                                
                                Text ("Hey Buddies!")
                                
                                Text("Invite your friend by creating new room or join room to start the duel")
                                    .fontWeight(.semibold)
                                
                            }
                            .frame(width: 160, height: 190)
                            
                            Spacer()
                            
                        }
                        .frame(width: 330)
                        
                        
                        HStack {
                            
                            Spacer()
                            
                                Image("ButoIjo")
                            
                        }
                    }
                    .ignoresSafeArea()
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Create Room")
                            .font(.title3)
                    })
                    .buttonStyle(ActiveBlackButtonDuel())
                    .padding()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Join Room")
                            .font(.title3)
                    })
                    .buttonStyle(ActiveBlackButtonDuel())
                    
                }
                .frame(height: 526)
                
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(true)
            
        }
        
    }
    
}

#Preview {
    DuelModeView()
}
