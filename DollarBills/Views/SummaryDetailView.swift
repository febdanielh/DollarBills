//
//  SummaryDetailView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 28/10/23.
//

import SwiftUI

struct SummaryDetailView: View {
    
    @EnvironmentObject var vm : ViewModel
    
    @State var picking : Bool = false
    
    @State var pickedDate = Date()
    
    @State var todaysWorkout : Workout?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
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
            
            ScrollView {
                
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
                        
                        Text("Your Run")
                            .font(.title3).bold()
                            .padding(.horizontal)
                        
                        if (todaysWorkout == nil) {
                            
                            Text("No runs found on this day.")
                                .padding(.horizontal)
                            
                        }
                        
                        else {
                            
                            VStack(alignment: .leading, spacing: 18) {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color.TextDimGray)
                                    .frame(height: 350)
                                VStack(alignment: .leading){
                                    Text("HARUSNYA NAMA RUTE")
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading)
                                    
                                    HStack {
                                        Image("Pinpoint")
                                        Text("HARUSNYA NAMA DAERAH")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.YellowDark4)
                                    }.padding(.leading).padding(.bottom, 10)
                                }.padding(.bottom)
                            }
                            .background(.white)
                            .cornerRadius(16)
                            .padding([.bottom, .leading, .trailing])
                            
                            HStack(spacing: 5){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                    VStack{
                                        Text((todaysWorkout?.formattedDistance())!)
                                            .font(.headline).padding(.bottom, 10)
                                        Text("Distance")
                                            .font(.footnote)
                                    }
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                    VStack{
                                        Text((todaysWorkout?.formattedDuration())!)
                                            .font(.headline).padding(.bottom, 10)
                                        Text("Duration")
                                            .font(.footnote)
                                    }
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                        .frame(height: 115)
                                    VStack{
                                        Text((todaysWorkout?.formattedPace())!)
                                            .font(.headline).padding(.bottom, 10)
                                        Text("Pace")
                                            .font(.footnote)
                                    }
                                }
                            }.padding(.horizontal)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                    .frame(height: 87)
                                VStack{
                                    Text("Elevation")
                                        .font(.footnote).fontWeight(.semibold)
                                }
                            }.padding()
                            
                            HStack(spacing: 5){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                    VStack{
                                        Text(String(todaysWorkout!.heartRate))
                                            .font(.footnote).fontWeight(.semibold).padding(.bottom, 10)
                                        Text("Heart Rate")
                                            .font(.caption2)
                                    }
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                    VStack{
                                        Text(String(todaysWorkout!.calorieBurned))
                                            .font(.footnote).fontWeight(.semibold).padding(.bottom, 10)
                                        Text("Energy")
                                            .font(.caption2)
                                    }
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(.white)
                                        .frame(height: 115)
                                    VStack{
                                        Text("BELUM ADA")
                                            .font(.footnote).fontWeight(.semibold).padding(.bottom, 10)
                                        Text("Steps")
                                            .font(.caption2)
                                    }
                                }
                            }.padding(.horizontal)
                            
                            
                            Text("Item")
                                .font(.title3).bold()
                                .padding(.leading)
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                    .frame(height: 87)
                                HStack{
                                    ForEach (0 ..< todaysWorkout!.itemsCollected.count) { i in
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundStyle(.white)
                                                .frame(width: 48, height: 48)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                                                lineWidth: 2)
                                                        .shadow(radius: 3, x: 2, y: 2)
                                                        .clipShape(
                                                            RoundedRectangle(cornerRadius: 15)
                                                        )
                                                )
                                            
                                            Image(todaysWorkout!.itemsCollected[i].image)
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                            
                                        }
                                    }
                                    Spacer()
                                }.padding(.horizontal)
                            }.padding([.horizontal, .bottom])
                            
                            Text("Duel Mode")
                                .font(.title3).bold()
                                .padding(.leading)
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                    .frame(height: 100)
                                HStack{
                                    Text("User")
                                    Spacer()
                                    Text("Opponent")
                                }.padding(.horizontal)
                            }.padding([.horizontal, .bottom])
                            
                        }
                        
                    }
                }
            }
        }
        .onChange(of: pickedDate) { oldValue, newValue in
            todaysWorkout = vm.getThatDay(pickedDate: pickedDate)
        }
        
    }
}

#Preview {
    SummaryDetailView()
}
