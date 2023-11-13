//
//  PopUp.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct PopUp: View {
    
//    @Binding private var text: String
    
    var body: some View {
        ZStack {
            
            Image("frame1")
                .resizable()
                .frame(width: 200, height: 200)
                .offset(x: 0, y: -40)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.yellow)
                .frame(width: 179, height: 120)
            Text("Access Furthr on you iPhone to activate the watchApp.")
                .foregroundStyle(Color.black)
                .padding(.horizontal, 20)
            
        }
    }
}

#Preview {
    PopUp()
}
