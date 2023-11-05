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
    
    @EnvironmentObject var vm : ViewModel
    var itemCount: Int = 6
    @State var progress = 0.1
    
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    var body: some View {
        
        ScrollView {
            
            VStack {
                
                // Date and See All
                VStack (alignment: .leading) {
                    
                    Text(Date.now.formatted(date: .complete, time: .omitted))
                        .textCase(.uppercase)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(Color.TextDimGray)
                    
                    HStack {
                        Text ("Today")
                            .font(.title)
                            .bold()
                        Spacer()
                        NavigationLink {
                            SummaryDetailView(todaysWorkout: vm.getThatDay(pickedDate: Date()))
                        } label: {
                            Text("See All >")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.TextDimGray)
                        }
                    }.padding(.vertical, 5)
                }
                .frame(width: 357)
                .padding(.horizontal)
                
                if (vm.getToday() == nil) {
                    
                    Text("No workout has been recorded yet for today!")
                    
                } else {
                    
                    // All Image
                    VStack(spacing: 12) {
                        
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
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.YellowDark4)
                                
                            }
                            .frame(height: 5)
                            .padding(.bottom)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text ("\(vm.getToday()!.formattedDistance())")
                                        .font(.headline)
                                    Text ("Distance")
                                        .font(.footnote)
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text ("\(vm.getToday()!.formattedDuration())")
                                        .font(.headline)
                                    Text ("Duration")
                                        .font(.footnote)
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text ("\(vm.getToday()!.formattedPace())")
                                        .font(.headline)
                                    Text ("Pace")
                                        .font(.footnote)
                                }
                            }
                            .padding(.trailing)
                            
                            VStack (alignment: .leading) {
                                Text ("Elevation")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Image ("Elevation")
                            }
                            .padding([.trailing, .top])
                            
                            HStack {
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
                            }
                            .padding([.vertical, .trailing])
                            
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
                                        
                                        if (i % 2 == 0) {
                                            Image("\(i)Potion")
                                                .resizable()
                                                .frame(width: 80, height: 60)
                                        } else {
                                            Image("\(i)Rock")
                                                .resizable()
                                                .frame(width: 80, height: 60)
                                        }
                                        
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
                                        
                                        if (i % 2 == 0) {
                                            Image("\(i)Potion")
                                                .resizable()
                                                .frame(width: 48, height: 36)
                                        } else {
                                            Image("\(i)Rock")
                                                .resizable()
                                                .frame(width: 48, height: 36)
                                        }
                                        
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
                }
                
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
        .onAppear {
            vm.loadWorkouts()
        }
        
    }
}

#Preview {
    SummaryView().environmentObject(ViewModel())
    //    VerticalProgressBar(progress: 0.6, day: 1)
}
