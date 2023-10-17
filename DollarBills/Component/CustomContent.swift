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
            .frame(width: 360, height: 53)
            .foregroundColor(.primaryColor02)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}

struct ActivePrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 360, height: 53)
            .foregroundColor(.black)
            .background(Color.primaryColor01)
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
                    .fill(Color(red: 1, green: 0.96, blue: 0.75))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        
                        RoundedRectangle(cornerRadius: 12.0)
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
