//
//  BoostView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct BoostView: View {
    //let items: Items
    var body: some View {
        VStack{
            Text("10:00 sec") //items.timeEffect
                .font(.title2)
            Image("itemRock") //items.imgae
                .resizable()
                .frame(width: 200, height: 150)
                .padding(.top, -25)
            Text("Distance Doubled") //items.descSummary
                .font(.title3)
                .padding(.top, -20)
        }
    }
}

#Preview {
    BoostView()
}
