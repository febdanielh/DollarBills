//
//  ChooseItemView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ChooseItemView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Choose 3 items for duel")
                .fontWeight(.bold)
                .font(.title3)
            
            HStack (spacing: 5){
                ChosenItemContainer()
                ChosenItemContainer()
                ChosenItemContainer()
            }
            
            Spacer()
            ItemsSheet()
        }
        .ignoresSafeArea()
        
            
    }
}

#Preview {
    ChooseItemView()
}
