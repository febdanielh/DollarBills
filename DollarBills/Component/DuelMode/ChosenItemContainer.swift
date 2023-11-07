//
//  ChosenItemContainer.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ChosenItemContainer: View {
    var body: some View {
        
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 118, height: 120)
              .background(Color(red: 1, green: 0.99, blue: 0.94))
              .cornerRadius(16)
              .overlay(
                RoundedRectangle(cornerRadius: 16)
                  .inset(by: 0.50)
                  .stroke(Color(red: 1, green: 0.95, blue: 0.70), lineWidth: 0.50)
              )
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
              )
            Image("itemRock")
        }
    }
}

#Preview {
    ChosenItemContainer()
}
