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
        
        VStack {
            
            // GM & Race
            HStack {
                
                Text("Good Morning")
                    .font(.system(size: 13))
                
                Spacer()
                
                Button(action: {
                    
                    
                    
                }, label: {
                    
                    HStack (spacing: -4) {
                        Circle()
                            .foregroundStyle(Color.YellowDark)
                            .frame(width: 10, height: 10)
                            .padding(.leading)
                        Text("Qokka Race")
                            .frame(width: 102, height: 2)
                            .font(.system(size: 14))
                            .padding([.top, .bottom])
                            .foregroundColor(Color.YellowDark)
                        
                    }
                    .padding([.leading, .trailing])
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.YellowNormal, lineWidth: 2)
                    )
                    .background(Color.YellowNormal) // If you have this
                    .cornerRadius(15)
                    
                })
                
            }
            .padding(.leading)
            .frame(width: 356)
            
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
                .frame(width: 356)
            
            Divider()
            
            ScrollView {
                
                VStack {
                    
                    Text("Routes of The Week 🔥")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .frame(width: 361)
                    
                    // Routes of The Week
                    ScrollView(.horizontal) {
                        
                        // All Image
                        HStack {
                            
                            ForEach (vm.annotations, id:\.self) { i in
                                
                                Button {
                                    
                                    vm.selectedAnnotation = i.annotationModel
                                    vm.currentDisplayScreen = .viewMap
                                    
                                    
                                } label: {
                                    
                                    ZStack {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            RoundedRectangle(cornerRadius: 16)
                                                .foregroundStyle(.white)
                                                .background(
                                                    Color.YellowNormal)
                                                .cornerRadius(16.0)
                                                .overlay (
                                                    RoundedRectangle(cornerRadius: 16.0)
                                                        .stroke(Color.gray, lineWidth: 1)
                                                )
                                                .frame(width: 359, height: 210)
                                            
                                        }
                                        
                                        VStack (alignment: .leading)
                                        {
                                            
                                            // One Image
                                            Image(i.annotationModel.routeName)
                                                .resizable()
                                                .frame(width: 360, height: 155)
                                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                                            
                                            VStack (alignment: .leading) {
                                                Text(i.title!)
                                                    .foregroundStyle(Color.black)
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                HStack {
                                                    Text(i.location!)
                                                        .font(.caption)
                                                        .foregroundStyle(Color.black)
                                                }
                                                
                                            }
                                            .padding(.leading)
                                            
                                        }
                                        
                                        // Location Tag
                                        VStack {
                                            
                                            Spacer()
                                            
                                            Text("5 km")
                                                .font(.system(size: 13))
                                                .foregroundStyle(Color.YellowDark)
                                                .frame(width: 55, height: 20, alignment: .center)
                                                .background(
                                                    Color.YellowNormal)
                                                .cornerRadius(16.0)
                                                .overlay (
                                                    RoundedRectangle(cornerRadius: 16.0)
                                                        .stroke(Color.YellowDark, lineWidth: 1)
                                                )
                                            
                                        }
                                        .frame(width: 290, height: 130, alignment: .trailing)
                                        
                                    }
                                    .padding(.bottom)
                                    
                                }
                                
                                
                            }
                        }
                        .padding([.leading,.trailing])
                        
                    }
                    .padding(.bottom)
                    
                    // Nearest to You
                    HStack {
                        
                        Text("Nearest to You")
                            .foregroundStyle(.black)
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
                                    
                                    ZStack {
                                        
                                        VStack (alignment: .leading)
                                        {
                                            
                                            // One Image
                                            Image("RouteBox/\(i)")
                                                .resizable()
                                                .frame(width: 180, height: 155)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                            
                                            VStack (alignment: .leading) {
                                                
                                                HStack {
                                                    Text("Foresta")
                                                        .font(.title3)
                                                        .fontWeight(.semibold)
                                                }
                                                
                                                HStack {
                                                    Text("BSD, Tangerang")
                                                        .font(.caption)
                                                }
                                                
                                                HStack {
                                                    Text("50m away")
                                                        .font(.caption)
                                                }
                                                
                                            }
                                            .padding(.leading)
                                            
                                        }
                                        
                                        // New!
                                        VStack {
                                            Image("New!")
                                                .frame(width: 180, height: 21, alignment: .leading)
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                    // Location Tag
                                    VStack {
                                        
                                        Text("4+ Routes")
                                            .font(.system(size: 13))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.black)
                                            .frame(width: 90, height: 20, alignment: .center)
                                            .background(
                                                Color.YellowNormal)
                                            .cornerRadius(16.0)
                                            .overlay (
                                                RoundedRectangle(cornerRadius: 16.0)
                                                    .stroke(Color.YellowNormal, lineWidth: 0)
                                            )
                                    }
                                    .frame(width: 160, alignment: .leading)
                                    .padding(.bottom)
                                    
                                }
                                .background(.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 4)
                                
                            }
                        }
                        .padding([.bottom, .leading,.trailing])
                        
                    }
                    .padding(.bottom)

                    .cornerRadius(8)
                    
                    HStack {
                        
                        Text("Qokka's Pick")
                            .foregroundStyle(.black)
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
                                        
                                        VStack (alignment: .leading)
                                        {
                                            
                                            // One Image
                                            Image("RouteBox/\(i)")
                                                .resizable()
                                                .frame(width: 180, height: 155)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                            
                                            VStack (alignment: .leading) {
                                                
                                                HStack {
                                                    Text("Foresta")
                                                        .font(.title3)
                                                        .fontWeight(.semibold)
                                                }
                                                
                                                HStack {
                                                    Text("BSD, Tangerang")
                                                        .font(.caption)
                                                }
                                                
                                                HStack {
                                                    Text("50m away")
                                                        .font(.caption)
                                                }
                                                
                                            }
                                            .padding(.leading)
                                            
                                        }
                                        
                                        // Location Tag
                                        VStack {
                                            
                                            Spacer()
                                            
                                            Text("5 km")
                                                .font(.system(size: 13))
                                                .foregroundStyle(Color.YellowDark)
                                                .frame(width: 55, height: 20, alignment: .center)
                                                .background(
                                                    Color.YellowNormal)
                                                .cornerRadius(16.0)
                                                .overlay (
                                                    RoundedRectangle(cornerRadius: 16.0)
                                                        .stroke(Color.YellowDark, lineWidth: 1)
                                                )
                                            
                                        }
                                        .frame(width: 160, height: 110, alignment: .trailing)
                                        
                                    }
                                    .padding(.bottom)
                                    
                                }
                                .background(.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 4)
                                
                            }
                        }
                        .padding([.bottom, .leading,.trailing])
                        
                    }
                    .padding(.bottom)
                    
                    
                }
                .frame(width: .infinity)
                
            }
            .scrollIndicators(.hidden)
            
        }
        
    }
    
}

#Preview {
    ExploreView()
        .environmentObject(ViewModel())
}
