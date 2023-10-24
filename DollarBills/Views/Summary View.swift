//
//  ContentView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 26/09/23.
//

import SwiftUI
import CoreData
import MapKit

struct SummaryView: View {
    
    @EnvironmentObject var VM : ViewModel
    var itemCount: Int = 6
    @State var progress = 0.1
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                // Date and See All
                HStack {
                    
                    VStack (alignment: .leading) {
                        
                        Text("Thursday, 28 Sep")
                            .textCase(.uppercase)
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(Color.TextDimGray)
                        
                        Text ("Today")
                            .font(.title)
                            .bold()
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            
                            HStack (spacing: 4) {
                                Text ("See All")
                                Image ("Arrow")
                            }
                            
                        })
                        .tint(Color.TextDimGray)
                        
                    }
                    
                }
                .frame(height: 48)
                .padding([.bottom,.leading,.trailing])
                
                // All Image
                VStack {
                    
                    // Image Container
                    Button (action: {
                        
                    }, label: {
                        Rectangle()
                            .foregroundStyle(Color.TextDimGray)
                            .frame(width: 357, height: 159)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    
                    // Statistic Container
                    VStack (alignment: .leading) {
                        
                        Text("Foresta Lumino Run")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            
                            Image("Pinpoint")
                            
                            Text("BSD, Tangerang")
                                .font(.subheadline)
                                .foregroundStyle(Color.YellowDark4)
                            
                        }
                        .frame(height: 5)
                        .padding(.bottom)
                        
                        HStack {
                            
                            Spacer()
                            
                            VStack {
                                Text ("5km")
                                    .fontWeight(.semibold)
                                Text ("Distance")
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text ("45 min")
                                    .fontWeight(.semibold)
                                Text ("Duration")
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text ("8")
                                    .fontWeight(.semibold)
                                Text ("Pace")
                            }
                            
                            Spacer()
                            
                        }
                        .padding([.top, .bottom])
                        
                        VStack (alignment: .leading) {
                            Text ("Elevation")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Image ("Elevation")
                        }
                        .padding([.trailing, .top])
                        
                        HStack {
                            
                            Spacer()
                            
                            VStack {
                                Text ("103-168 bpm")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text ("Heart Rate")
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text ("400 kcal")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text ("Energy")
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text ("4123")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text ("Steps")
                                    .font(.caption2)
                            }
                            
                            Spacer()
                            
                        }
                        .padding([.top, .bottom])
                        
                    }
                    .padding(.leading)
                    
                    // Content
                    HStack {
                        
                        if (itemCount <= 5) {
                            
                            ForEach (0 ..< itemCount) { i in
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(.white)
                                        .frame(width: 48, height: 48)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                                        lineWidth: 2)
                                                .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                                                        radius: 3, x: 2, y: 2)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 15)
                                                )
                                                .shadow(color: Color.white, radius: 3, x: 2, y: 2)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 15)
                                                )
                                        )
                                    
                                    Image("Potion\(i)")
                                    
                                }
                            }
                            
                        } else {
                            
                            ForEach (0 ..< 5) { i in
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(.white)
                                        .frame(width: 48, height: 48)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                                        lineWidth: 2)
                                                .shadow(color: Color(red: 192/255, green: 189/255, blue: 191/255),
                                                        radius: 3, x: 2, y: 2)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 15)
                                                )
                                                .shadow(color: Color.white, radius: 3, x: 2, y: 2)
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 15)
                                                )
                                        )
                                    
                                    Image("Potion\(i)")
                                    
                                }
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                Text("More")
                                    .font(.caption2)
                                    .foregroundStyle(.black)
                                    .frame(width: 53, height: 21)
                                    .background(Color.YellowNormal)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            })
                            
                        }
                        
                    }
                    .padding(.bottom)
                    
                }
                .background(.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 4)
                .padding([.bottom, .leading, .trailing])
                
                // Weekly Perfomance
                HStack {
                    
                    Text ("Weekly Performance")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    
                    Spacer()
                    
                }
                .frame(height: 48)
                .padding([.leading,.trailing])
                
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.WPBG)
                    
                    VStack {
                        
                        HStack {
                            
                            Text("Your run was up for 50% compared to last week.")
                                .padding(.top)
                            
                            Spacer()
                            
                        }
                        .frame(width: 314, height: 60)
                        
                        HStack(alignment: .center){
                            
                            ForEach (1 ..< 8) { i in
                                
                                VStack {
                                    
                                    VerticalProgressBar(progress: progress * Double(i), day: i)
                                        .padding(.bottom)
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        .frame(width: 301)
                        
                        
                    }
                    
                    Spacer()
                    
                }
                .frame(width: 354, height: 344)
                
            }
            
        }
        
    }
    
}

#Preview {
    SummaryView().environmentObject(ViewModel())
//    VerticalProgressBar(progress: 0.6, day: 1)
}
