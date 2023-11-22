//
//  AttackedView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct AttackedView: View {
    var body: some View {
        VStack{
            Text("10:00 sec")
                .font(.title2)
            ZStack{
                
                Image("itemRock")
                    .resizable()
                    .frame(width: 200, height: 150)
                    .padding(.top, -25)
                Image("exclamation")
                    .offset(x: 60, y: -45)
            }
            
            Text("Distance Doubled")
                .font(.title3)
                .padding(.top, -20)
        }
    }
}

#Preview {
    AttackedView()
}
