//
//  SeeAllView.swift
//  DollarBills
//
//  Created by Elvis Susanto on 23/11/23.
//

import Foundation
import SwiftUI

struct SeeAllView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State var pickedDate = Date()
    
    @State var picking : Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack (spacing: 12) {
                
                Button(action: {
                    pickedDate = pickedDate.addingTimeInterval(-86400)
                }, label: {
                    Image(systemName: "chevron.left") ///ini diganti atau perubahan tanggalnya per minggu
                })
                .foregroundStyle(.black)
                
                
                Text(pickedDate.formatted(date: .complete, time: .omitted))
                    .bold()
                
                Button(action: {
                    pickedDate = pickedDate.addingTimeInterval(86400)
                    
                }, label: {
                    Image(systemName: "chevron.right") ///sama ni per minggu, maju mundur
                })
                .foregroundStyle(.black)
                
                //                Spacer()
                
                Button(action: {
                    picking.toggle()
                }, label: {
                    Image(systemName: "calendar")
                }) ///buka kalender
                .foregroundStyle(.black)
                
                
            }.padding().frame(maxWidth: .infinity)

            if picking {
                DatePicker(
                    "Start Date",
                    selection: $pickedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .tint(.black)
                .padding()
            }

            Divider()
            
            ZStack {
                Color.SheetGray
                VStack(alignment: .leading) {
                    
                    HStack(spacing: 40) {
                        
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Mon") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("M")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Tue") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("T")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Wed") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("W")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Thu") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("T")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Fri") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("F")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Sat") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("S")
                        }
                        
                        ZStack {
                            
                            if (pickedDate.formatted(Date.FormatStyle().weekday(.abbreviated)) == "Sun") {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                            }
                            
                            Text("S")
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .font(.caption).fontWeight(.semibold)
                    .padding()
                    
                    ScrollView {
                        
                        VStack {
                            
                            if vm.supaWorkoutsExactDay.isEmpty {
                                
                                Text("No workouts recorded for today!")
                                    .font(.title3)
                                    .bold()
                                    .padding()
                                
                            } else {
                                
                                VStack {
                                    
                                    ForEach(0 ..< vm.supaWorkoutsExactDay.count) { index in
                                        
                                        NavigationLink(destination:
                                            SummaryDetailView(index: index)
                                        ) {
                                            
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: 8)
                                                    .frame(width: 354)
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 1, x:2, y:2)
                                                
                                                HStack {
                                                    
                                                    VStack (alignment: .leading) {
                                                        
                                                        Text(vm.supaWorkoutsExactDay[index].routeName)
                                                            .font(.title3)
                                                            .bold()
                                                        Text("\(vm.supaWorkoutsExactDay[index].startDate.formatted(date: .complete, time: .shortened))")
                                                            .font(.caption)
                                                        
                                                    }
                                                    .multilineTextAlignment(.leading)
                                                    .padding()
                                                    
                                                    Spacer()
                                                    
                                                }
                                                
                                            }
                                            .tint(.black)
                                        }
                                        
                                        
                                    }
                                    
                                }
                                .padding([.leading, .trailing, .bottom])
                                
                            }
                            
                        }
                        
                    }
                    
                }
            }

            Divider()
            
        }
        .navigationTitle("See All")
        
    }
    
}


