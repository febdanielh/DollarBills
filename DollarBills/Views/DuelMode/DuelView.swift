//
//  DuelView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct DuelView: View {
    var body: some View {
        VStack (spacing: 15){
            Text("Switch to Apple watch for Duel Mode")
                .font(Font.custom("SF Pro", size: 17))
                .lineSpacing(16)
                .italic()
            
            
            Image( systemName:"applewatch.radiowaves.left.and.right")
                .font(Font.custom("SF Pro", size: 29.97).weight(.black))
                .lineSpacing(44.96)
                
        }
        .italic()
        .foregroundColor(Color(red: 0.57, green: 0.57, blue: 0.57))
    }
}

#Preview {
    DuelView()
}
