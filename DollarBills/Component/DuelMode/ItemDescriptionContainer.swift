//
//  ItemDescriptionContainer.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ItemDescriptionContainer: View {
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 8){
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 97, height: 94)
                            .background(Color(red: 0.98, green: 0.97, blue: 0.97))
                            .cornerRadius(8)
                        Image("0Potion")
                            .resizable()
                            .frame(width: 97, height: 80)
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 44, height: 20)
                                        .background(Color(red: 0.34, green: 0.35, blue: 0.36))
                                        .cornerRadius(4.67)
                                    Text("x1")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .lineSpacing(34.43)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }.frame(width: 97, height: 94)
                    VStack (spacing: 8){
                        Text("Blue Potion")
                            .font(.footnote)
                            .fontWeight(.bold)
                        Text("Double up distance obtained in 20 seconds")
                            .font(Font.custom("SF Pro", size: 11))
                    }
                    .frame(width: 89)
                    .multilineTextAlignment(.center)
                }
            }
        }
        .padding(0)
        .frame(width: 97, height: 172, alignment: .top)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: -0.25)
                .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 0.5)
        )
    }
}

#Preview {
    ItemDescriptionContainer()
}
