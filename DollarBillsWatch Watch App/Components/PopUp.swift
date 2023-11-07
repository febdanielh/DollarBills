//
//  PopUp.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct PopUp: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.yellow)
                .frame(width: 179, height: 131)
            Text("Access Furthr on you iPhone to activate the watchApp.")
                .foregroundStyle(Color.black)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PopUp()
}
