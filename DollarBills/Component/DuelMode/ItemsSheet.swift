//
//  ItemsSheet.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ItemsSheet: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 390, height: 463)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            VStack (spacing: 0){
                Text("Your Items")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ItemDescriptionContainer()
                        ItemDescriptionContainer()
                        ItemDescriptionContainer()
                        ItemDescriptionContainer()
                    }
                    .frame(height: 300)
                }
                
               
                
                NavigationLink {
                    DuelView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 326, height: 45)
                            .foregroundColor(Color.black)
                        Text("Start Duel")
                            .foregroundColor(Color.white)
                            .font(.title3)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ItemsSheet()
}

