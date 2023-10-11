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
