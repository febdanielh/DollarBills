//
//  BoostView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct BoostView: View {
    var body: some View {
        VStack{
            Text("10:00 sec")
                .font(.title2)
            Image("itemRock")
                .resizable()
                .frame(width: 200, height: 150)
                .padding(.top, -25)
            Text("Distance Doubled")
                .font(.title3)
                .padding(.top, -20)
        }
    }
}

#Preview {
    BoostView()
}
