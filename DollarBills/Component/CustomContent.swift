//
//  CustomButtons.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 06/10/23.
//

import Foundation
import SwiftUI

struct FillButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 293, height: 56)
            .background(configuration.isPressed ? Color("Green: Active") : Color("Green: Normal"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(configuration.isPressed ? Color("Green: Active") : Color("Green: Normal"))
            )
            .cornerRadius(6)
            .foregroundColor(configuration.isPressed ? Color(.white) : Color(.white))
    }
}

struct ActiveBlackButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 44)
            .foregroundColor(.white)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct ActiveBlackButtonDuel: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 326, height: 60)
            .foregroundColor(.YellowLight1)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct ActiveBlackButtonProfile: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 310, height: 60)
            .foregroundColor(Color.white)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct ActiveBlackSheetButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 306, height: 44)
            .foregroundColor(.white)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct ActivePrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 360, height: 53)
            .foregroundColor(.black)
            .background(Color.YellowNormal)
            .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}

struct RouteTitle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .lineLimit(1)
            .foregroundStyle(Color("Blue: Darker"))
            .padding(.top)
            .frame(width: 356, alignment: .leading)
    }
}

struct RouteInfo : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .lineLimit(1)
            .foregroundStyle(.black)
    }
}

struct BarProgressStyle: ProgressViewStyle {
    var color: Color = .green
    var height: Double = 20.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader{ geometry in
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color.emptyProgressBar)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(Color.YellowNormal2)
                            .frame(width: geometry.size.width * min(progress, 1.0))
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                    }
            }
        }
    }
}

struct BarProgressStyleDuel: ProgressViewStyle {
    var color: Color = .green
    var height: Double = 12.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader{ geometry in
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(Color.PBBG)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: 8.0)
                            .fill(Color(red: 1, green: 0.87, blue: 0.2))
                            .frame(width: geometry.size.width * min(progress, 1.0))
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                    }
            }
        }
    }
}

struct ExDivider: View {
    let color: Color = .black
    let height: CGFloat = 2
    let width: CGFloat
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: height)
    }
}

struct VerticalProgressBar: View {
    
    var progress: Double
    var day: Int
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack (alignment: .center) {
                Spacer()
                ZStack() {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 26, height: CGFloat(progress) * geometry.size.height)
                        .foregroundColor(Color.YellowNormal)
                    
                }
                .padding(.bottom)
                if (day == 1) {
                    Text("S")
                }
                if (day == 2) {
                    Text("S")
                }
                if (day == 3) {
                    Text("M")
                }
                if (day == 4) {
                    Text("T")
                }
                if (day == 5) {
                    Text("W")
                }
                if (day == 6) {
                    Text("T")
                }
                if (day == 7) {
                    Text("F")
                }
                
            }
            .font(.caption)
            .fontWeight(.semibold)
            
        }
        
    }
}

struct LeaderboardBar: View {
    
    var points: Double
    var rank: Int
    var name: String
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("\(rank)")
                    .font(.system(size: 45)).fontWeight(.black)
                    .italic()
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: 96, height: CGFloat(points) / 2.5)
                        .foregroundColor(Color.leaderboardOrange)
                    RoundedRectangle(cornerRadius: 150)
                        .frame(width: 100, height: 10)
                        .foregroundColor(Color.leaderboardLightOrange)
                    VStack{
                        Text(name)
                            .font(.footnote).bold()
                            .foregroundColor(.white)
                        HStack {
                            Image("coin")
                                .resizable()
                                .frame(width: 14, height: 14)
                            Text("15000")
                                .font(.system(size: 9))
                                .foregroundColor(Color.YellowDark26)
                        }
                        .frame(width: 80, height: 18)
                        .background(Color.YellowLight2)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.YellowLight3)
                        )
                        .cornerRadius(4)
                    }
                    .offset(y: -CGFloat(points / 5))
                }
            }
        }
    }
}

#Preview(body: {
    LeaderboardBar(points: 800, rank: 1, name: "Guest 7777")
})
