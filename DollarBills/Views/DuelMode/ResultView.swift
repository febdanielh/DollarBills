//
//  ResultView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var game: RealTimeGame
    var body: some View {
        VStack {
            Text("Duel Mode").font(.headline)
                .padding()
            Divider()
            ScrollView (showsIndicators: false){
                Spacer().frame(height: 28)
                VStack (spacing: 20){
                    Text("Congratulations!")
                        .font(.title3)
                    Text("You Win")
                        .font(.system(size: 30)).bold()
                    
                    ZStack {
                        DuelAnimation()
                            .frame(height: 250)
                        Image("resultFlag")
                            .offset(y: 18)
                            .shadow(radius: 2)
                        HStack {
                            Text(game.myName)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                            Text(game.opponentName)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 10)
                        .frame(width: 340)
                    }
                    
                    Text("Monday, 16 October 2023")
                        .font(.subheadline).fontWeight(.medium)
                    
                    
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
                        SubtitleView(textSub: "DISTANCE")
                        HStack{
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 44)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 1)
                                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                                        
                                    )
                                
                                Text("5.00 km")
                                    .font(.headline)
                                    .foregroundStyle(Color.black2)
                            }
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 44)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 1)
                                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                                        
                                    )
                                Text("3.75 km")
                                    .font(.headline)
                                    .foregroundColor(Color.black2)
                                
                            }
                        }
                        
                        SubtitleView(textSub: "OPPONTENT'S ATTACK")
                        HStack{
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 131)
                                    .cornerRadius(8)
                                    .opacity(0.80)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 1)
                                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                                        
                                    )
                                
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
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 1)
                                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                                        
                                    )
                                
                                VStack (spacing: 3){
                                    ItemDeductPointView()
                                    ItemDeductPointView()
                                    ItemDeductPointView()
                                }
                            }
                        }
                        SubtitleView(textSub: "ITEMS USED")
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
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 1)
                                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                                        
                                    )
                                
                                HStack(spacing: 3){
                                    ItemView()
                                    ItemView()
                                    ItemView()
                                }
                            }
                        }
                        SubtitleView(textSub: "TOTAL DISTANCE")
                        HStack{
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 69)
                                    .background(Color(red: 0.09, green: 0.56, blue: 1))
                                    .cornerRadius(8.33)
                                Text("4.72 km")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 170, height: 69)
                                    .background(Color(red: 0.76, green: 0.03, blue: 0.03))
                                    .cornerRadius(8.33)
                                Text("3.57 km")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(RealTimeGame())
}

struct SubtitleView: View {
    let textSub: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 345, height: 36)
                .background(Color.black2)
                .cornerRadius(8.33)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.33)
                        .inset(by: 0.52)
                        .stroke(Color(red: 0.66, green: 0.66, blue: 0.66), lineWidth: 0.52)
                )
            Text(textSub)
                .font(.footnote).fontWeight(.semibold)
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
            Image("2Potion")
                .resizable()
                .frame(width: 40, height: 30)
        }
    }
}

struct ItemDeductPointView: View {
    
//    let itemsUsed: [String] --> buat nanti klo udah bisa di coba
    
    var body: some View {
//        VStack {
//            ForEach(itemsUsed.indices, id: \.self) { item in
//                HStack {
//                    Image("\(item)")
//                        .resizable()
//                        .frame(width: 40, height: 30)
//                    Text("-5 m")
//                }
//            }
//        }
        HStack{
            Image("2Potion")
                .resizable()
                .frame(width: 40, height: 30)
            Text("-5 m")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}
