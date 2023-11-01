//
//  SummaryDetailView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 28/10/23.
//

import SwiftUI

struct SummaryDetailView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack (spacing: 12){
                Image(systemName: "chevron.left") ///ini diganti atau perubahan tanggalnya per minggu
                
                Text("Today, 16 Oct 2023") ///ini tanggal sesuai harinya
                    .bold()
                
                Image(systemName: "chevron.right") ///sama ni per minggu, maju mundur
                //                Spacer()
                Image(systemName: "calendar") ///buka kalender
            }.padding().frame(maxWidth: .infinity)
            
            Divider()
            
            ScrollView {
                ZStack {
                    Color.SheetGray
                    VStack(alignment: .leading) {
                        HStack(spacing: 40) {
                            Text("M")
                            ZStack {
                                Circle()
                                    .frame(height: 24)
                                    .foregroundColor(Color.YellowNormal2)
                                Text("T")
                            }
                            Text("W")
                            Text("T")
                            Text("F")
                            Text("S")
                            Text("S")
                        }
                        .frame(maxWidth: .infinity)
                        .font(.caption).fontWeight(.semibold)
                        .padding()
                        
                        Text("Your Run")
                            .font(.title3).bold()
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 18) {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.TextDimGray)
                                .frame(height: 350)
                            VStack(alignment: .leading){
                                Text("Foresta BSD Run")
                                    .font(.title2)
                                    .bold()
                                    .padding(.leading)
                                
                                HStack {
                                    Image("Pinpoint")
                                    Text("BSD, Tangerang")
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
                                    Text("5.00 km")
                                        .font(.headline).padding(.bottom, 10)
                                    Text("Distance")
                                        .font(.footnote)
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                VStack{
                                    Text("45 min")
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
                                    Text("8'00\"")
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
                                    Text("103 - 168 BPM")
                                        .font(.footnote).fontWeight(.semibold).padding(.bottom, 10)
                                    Text("Distance")
                                        .font(.caption2)
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                VStack{
                                    Text("400 kcal")
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
                                    Text("4.123")
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
                                ForEach (0 ..< 3) { i in
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
}

#Preview {
    SummaryDetailView()
}
