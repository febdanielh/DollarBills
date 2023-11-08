//
//  ResultView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ResultView: View {
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (spacing:20){
                Text("Congratulations!")
                Text("You Win")
                    .font(.title)
                
                ZStack {
                    DuelAnimation()
                        .frame(height: 300)
                        .offset(y: -20)
                    Image("duelWinLose")
                    Text("Guest123")
                        .offset(x:110, y:-25)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("Guest123")
                        .offset(x:-110, y:-25)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }
                
                Text("Monday, 16 October 2023")
                
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 267, height: 55)
                        .background(Color(red: 0.99, green: 0.84, blue: 0.04))
                        .cornerRadius(200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 200)
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.89, green: 0.89, blue: 0.91), lineWidth: 0.50)
                        )
                    HStack (spacing: 40){
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 65, height: 19)
                                .background(Color(red: 1, green: 0.98, blue: 0.91))
                                .cornerRadius(200)
                            
                            Text("Challenge")
                                .font(.caption)
                        }
                        
                        Text("30:00")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                    }
                }
                
                
                VStack (spacing: 5){
                    SubtitleView()
                    HStack{
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 44)
                                .background(Color(red: 0.09, green: 0.56, blue: 1))
                                .cornerRadius(8)
                            
                            Text("5.00 km")
                                .font(.headline)
                                .foregroundColor(Color(red: 1, green: 1, blue: 1))
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 44)
                                .background(Color(red: 0.76, green: 0.03, blue: 0.03))
                                .cornerRadius(8)
                            Text("5.00 km")
                                .font(.headline)
                                .foregroundColor(Color(red: 1, green: 1, blue: 1))
                            
                        }
                    }
                    
                    SubtitleView()
                    HStack{
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 131)
                                .background(Color(red: 0.71, green: 0.85, blue: 0.98))
                                .cornerRadius(8.33)
                                .opacity(0.80)
                            
                            VStack (spacing: 3){
                                ItemDeductPointView()
                                ItemDeductPointView()
                                ItemDeductPointView()
                            }
                            
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 131)
                                .background(Color(red: 1, green: 0.69, blue: 0.69))
                                .cornerRadius(8)
                            
                            VStack (spacing: 3){
                                ItemDeductPointView()
                                ItemDeductPointView()
                                ItemDeductPointView()
                            }
                        }
                    }
                    SubtitleView()
                    HStack{
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 69)
                                .background(Color(red: 0.76, green: 0.87, blue: 0.98))
                                .cornerRadius(8.33)
                            .opacity(0.80)
                            
                            HStack(spacing: 3){
                                ItemView()
                                ItemView()
                                ItemView()
                            }
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 69)
                                .background(Color(red: 1, green: 0.69, blue: 0.69))
                            .cornerRadius(8.33)
                            
                            HStack(spacing: 3){
                                ItemView()
                                ItemView()
                                ItemView()
                            }
                        }
                    }
                    SubtitleView()
                    HStack{
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 69)
                                .background(Color(red: 0.09, green: 0.56, blue: 1))
                                .cornerRadius(8.33)
                            Text("3.70 km")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 170, height: 69)
                                .background(Color(red: 0.76, green: 0.03, blue: 0.03))
                                .cornerRadius(8.33)
                            Text("2.70 km")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                        
                    }
                }
                
            }
        }
        .padding(.top, 30)
        
    }
}

#Preview {
    ResultView()
}

struct SubtitleView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 345, height: 36)
                .background(Color(red: 0.32, green: 0.32, blue: 0.32))
                .cornerRadius(8.33)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.33)
                        .inset(by: 0.52)
                        .stroke(Color(red: 0.66, green: 0.66, blue: 0.66), lineWidth: 0.52)
                )
            Text("DISTANCE COVERED")
                .font(.headline)
                .lineSpacing(18)
                .foregroundColor(.white)
            
        }
    }
}

struct ItemView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(Color(red: 1, green: 0.69, blue: 0.69))
                .cornerRadius(8.33)
            Image("itemPotionRed")
                .resizable()
                .frame(width: 40, height: 30)
        }
    }
}

struct ItemDeductPointView: View {
    var body: some View {
        HStack{
            Image("itemPotionRed")
                .resizable()
                .frame(width: 40, height: 30)
            Text("-5 m")
                .font(.headline)
        }
    }
}
