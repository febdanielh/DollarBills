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
    @State var username = ""
    @State private var isEditing = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                // GM & Race
                HStack {
                    
                    Text("Good Morning")
                        .font(.system(size: 13))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        vm.currentDisplayScreen = .viewMap
                        
                    }, label: {
                        
                        HStack (spacing: -4) {
                            Circle()
                                .foregroundStyle(.yellow)
                                .frame(width: 10, height: 10)
                                .padding(.leading)
                            Text("Qokka Race")
                                .frame(width: 102, height: 2)
                                .font(.system(size: 14))
                                .padding([.top, .bottom])
                                .foregroundColor(.black)
                                
                        }
                        .padding([.leading, .trailing])
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                        )
                        .background(Color.white) // If you have this
                        .cornerRadius(15)
                        
                    })
                    
                }
                .frame(width: 361)
                
                // Search Bar
                TextField("Search for places or running routes", text: $username)
                    .font(.body)
                    .padding(7)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(30)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    .padding([.top, .bottom])
                    .frame(width: 361)
                    
                Text("Routes of The Week")
                    .foregroundStyle(Color.YellowDarker)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .frame(width: 361)
                
                // Routes of The Week
                ScrollView(.horizontal) {
                    
                    // All Image
                    HStack {
                        
                        ForEach (1 ..< 4) { i in
                            
                            ZStack {
                                
                                // One Image
                                Image("Keliling Foresta/\(i)")
                                    .resizable()
                                    .frame(width: 350, height: 187)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                                
                                // Location Tag
                                VStack {
                                    
                                    Text("Tanjung Duren Gaming")
                                        .font(.system(size: 8))
                                        .foregroundStyle(.black)
                                        .frame(width: 110, height: 20, alignment: .center)
                                        .background(
                                            Color.YellowLightactive)
                                        .clipShape(RoundedRectangle(cornerRadius: 16.0))
                                    
                                    Spacer()
                                    
                                }
                                .frame(maxWidth: 330, maxHeight: 160, alignment: .leading)
                                
                                // Route Name
                                VStack {
                                    
                                    Spacer()
                                    
                                    Text("\(i)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 190, height: 50, alignment: .center)
                                        .background(
                                            Color.black
                                                .opacity(0.6))
                                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16))
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .trailing)
                                
                            }
                            
                            
                        }
                    }
                    .padding([.leading,.trailing])
                    
                }
                
                Divider()
                    .padding()
                
                // Nearest to You
                HStack {
                    
                    Text("Nearest to You")
                        .foregroundStyle(Color.YellowDarker)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("See All >")
                            .font(.callout)
                            .foregroundStyle(Color.YellowDark)
                    })
                    
                    
                }
                .frame(width: 361)
                
                // Nearest to You 1
                ScrollView(.horizontal) {
                    
                    // All Image
                    HStack {
                        
                        ForEach (1 ..< 4) { i in
                            
                            VStack {
                                
                                // One Image
                                ZStack {
                                    
                                    Image("Keliling Foresta/\(i)")
                                        .resizable()
                                        .frame(width: 165, height: 179)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                                    
                                    // Location Tag
                                    VStack {
                                        
                                        Text("Tanjung Duren Gaming")
                                            .font(.system(size: 8))
                                            .foregroundStyle(.black)
                                            .frame(width: 110, height: 20, alignment: .center)
                                            .background(
                                                Color.YellowLightactive)
                                            .clipShape(RoundedRectangle(cornerRadius: 16.0))
                                        
                                        Spacer()
                                        
                                    }
                                    .frame(maxWidth: 150, maxHeight: 160, alignment: .leading)
                                    
                                }
                                
                                VStack {
                                    Text("Foresta")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .frame(width: 160, alignment: .leading)
                                    Text("50m away")
                                        .font(.callout)
                                        .foregroundStyle(Color.TextDimGray)
                                        .frame(width: 160, alignment: .leading)
                                }
                                
                                
                            }
                            
                        }
                    }
                    .padding([.leading,.trailing])
                    
                }
                
                Divider()
                    .padding()
                
                HStack {
                    
                    Text("Nearest to You")
                        .foregroundStyle(Color.YellowDarker)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("See All >")
                            .font(.callout)
                            .foregroundStyle(Color.YellowDark)
                    })
                    
                    
                }
                .frame(width: 361)
                
                // Nearest to You 2
                ScrollView(.horizontal) {
                    
                    // All Image
                    HStack {
                        
                        ForEach (1 ..< 4) { i in
                            
                            VStack {
                                
                                ZStack {
                                    
                                    // One Image
                                    Image("Keliling Nava/\(i)")
                                        .resizable()
                                        .frame(width: 165, height: 179)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                                    
                                    // Location Tag
                                    VStack {
                                        
                                        Text("Tanjung Duren Gaming")
                                            .font(.system(size: 8))
                                            .foregroundStyle(.black)
                                            .frame(width: 110, height: 20, alignment: .center)
                                            .background(
                                                Color.YellowLightactive)
                                            .clipShape(RoundedRectangle(cornerRadius: 16.0))
                                        
                                        Spacer()
                                        
                                    }
                                    .frame(maxWidth: 310, maxHeight: 160, alignment: .leading)
                                    
                                }
                                
                                VStack {
                                    Text("Foresta")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .frame(width: 160, alignment: .leading)
                                    Text("50m away")
                                        .font(.callout)
                                        .foregroundStyle(Color.TextDimGray)
                                        .frame(width: 160, alignment: .leading)
                                }
                                
                            }
                            
                            
                        }
                    }
                    .padding([.leading,.trailing])
                    
                }
                
                
            }
            .frame(width: .infinity)
            
        }
        .scrollIndicators(.hidden)
        
    }
    
}

#Preview {
    ExploreView()
        .environmentObject(ViewModel())
}
