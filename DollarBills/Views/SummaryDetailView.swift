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
    
    var index: Int
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                Color.SheetGray
                VStack(alignment: .leading) {
                    
                    Text("Your Run")
                        .font(.title3).bold()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        VStack(alignment: .leading){
                            
                            Text("\(vm.supaWorkoutsExactDay[index].routeName)")
                                .font(.title2)
                                .bold()
                                .padding(.leading)
                            
                        }
                        .padding(.bottom)
                        
                    }
                    .background(.white)
                    .cornerRadius(16)
                    .padding([.bottom, .leading, .trailing])
                    
                    HStack(spacing: 5){
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                            VStack{
                                Text("\(vm.supaWorkoutsExactDay[index].distance)")
                                    .font(.headline).padding(.bottom, 10)
                                Text("Distance")
                                    .font(.footnote)
                            }
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                            VStack{
                                Text("\(vm.supaWorkoutsExactDay[index].duration)")
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
                                Text("\(vm.supaWorkoutsExactDay[index].pace)")
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
                                Text(String(vm.workoutsExactDay[index].heartRate))
                                    .font(.footnote).fontWeight(.semibold).padding(.bottom, 10)
                                Text("Heart Rate")
                                    .font(.caption2)
                            }
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                            VStack{
                                Text(String(vm.workoutsExactDay[index].calorieBurned))
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
                            
                            ForEach (0 ..< vm.supaWorkoutsExactDay[index].itemName.count) { i in
                                
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
                                    
                                    Image("\(vm.supaWorkoutsExactDay[index].itemName[i])")
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
                        HStack(spacing: 3){
                            Rectangle()
                                .frame(height: 128)
                                .foregroundColor(Color.lightBlueDuel)
                            Rectangle()
                                .frame(height: 128)
                                .foregroundColor(Color.lightRedDuel)
                        }.clipShape(RoundedRectangle(cornerRadius: 8))
                        VStack (spacing: 8){
                            HStack{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 102, height: 24, alignment: .center)
                                        .foregroundColor(Color.blueResumeButton)
                                    Text("You")
                                        .font(.system(size: 10)).bold()
                                        .foregroundColor(.white)
                                }
                                Text("You Win")
                                    .font(.system(size: 14)).fontWeight(.semibold)
                                    .frame(width: 110)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 102, height: 24, alignment: .center)
                                        .foregroundColor(Color.redStopButton)
                                    Text("Reza")
                                        .font(.system(size: 10)).bold()
                                        .foregroundColor(.white)
                                }
                            }.padding(.horizontal)
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Total Distance")
                                        .font(.caption)
                                    Text("4.72 km")
                                        .font(.subheadline)
                                        .fontWeight(.black)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 5){
                                    Text("Total Distance")
                                        .font(.caption)
                                    Text("3.57 km")
                                        .font(.subheadline)
                                        .fontWeight(.black)
                                }
                            }.frame(width: 314).padding(.top, 10)
                        }.padding(.bottom)
                        CircleDuel()
                            .offset(y: 15)
                    }.padding([.horizontal, .bottom])
                    
                    
                }
            }
            
            Divider()
            
            ScrollView {
                
                
            }
        }
        .onChange(of: pickedDate) { oldValue, newValue in
            vm.getThatDay(pickedDate: pickedDate)
        }
        
    }
}

#Preview {
    CircleDuel()
}

struct CircleDuel: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(height: 63)
                .foregroundColor(Color.YellowLight23)
            Circle()
                .frame(height: 56)
                .foregroundColor(Color.YellowNormal2)
            Circle()
                .frame(height: 44)
                .foregroundColor(Color.YellowDark2)
            Text("VS")
                .font(.title3).bold()
                .foregroundColor(.white)
        }
    }
}
