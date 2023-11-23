//
//  AttackedView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct AttackedView: View {
//    let items: Items
    var body: some View {
        VStack{
            Text("10 sec") //items.timeEffect
                .font(.title3).fontWeight(.semibold)
                .padding(.top, -15)
            ZStack{
                Image("3Rock") //items.image
                    .resizable()
                    .frame(width: 200, height: 150)
                    .padding(.vertical, -5)
                Image("exclamation")
                    .offset(x: 60, y: -45)
            }
            Text("Distance Doubled") //items.descSummary
                .font(.title3).fontWeight(.semibold)
                .padding(.top, -15)
        }
    }
}

#Preview {
    AttackedView()
}
