//
//  ItemDescriptionContainer.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ItemDescriptionContainer: View {
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 99, height: 120)
                .cornerRadius(8)
                .padding(.top, 20)
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 99, height: 94)
                .background(Color(red: 0.98, green: 0.97, blue: 0.97))
                .cornerRadius(8)
                .offset(y: -70)
            
            
            Image("itemPotionBlue")
                .offset(y: -70)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 44, height: 20)
                .background(Color(red: 0.34, green: 0.35, blue: 0.36))
                .cornerRadius(4.67)
                .offset(x: 25, y: 35)
                .offset(y: -70)
            
            
            
            Text("x1")
                .font(.footnote)
                .fontWeight(.bold)
                .lineSpacing(34.43)
                .foregroundColor(.white)
                .offset(x: 25, y: 35)
                .offset(y: -70)
            
            VStack (spacing: 5){
                Text("Blue Potion")
                    .font(.footnote)
                    .fontWeight(.bold)
                Text("Double up distance obtained in 20 seconds")
                    .font(Font.custom("SF Pro", size: 11))
            }
            .frame(width: 80)
            .offset(x: 0, y: 20)
            .multilineTextAlignment(.center)
            
            
            
        }
        
    }
    
}

#Preview {
    ItemDescriptionContainer()
}
