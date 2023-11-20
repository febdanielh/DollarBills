//
//  Button.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct Button: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 175, height: 50)
                .foregroundStyle(Color.yellow)
            Text("Start Running")
                .foregroundStyle(Color.black)
                .font(.headline)
        }
        
    }
}

//#Preview {
//    Button()
//}
