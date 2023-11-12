//
//  LobbyPlayerName.swift
//  DollarBills
//
//  Created by Febrian Daniel on 08/11/23.
//

import SwiftUI

struct LobbyPlayerName: View {
    var body: some View {
        ZStack {
            HStack (spacing: 64){
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.YellowLight23)
                    .frame(width: 138, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20.90701)
                            .inset(by: 0.46)
                            .stroke(Color(red: 0.89, green: 0.89, blue: 0.91), lineWidth: 0.92)
                        
                    )
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.YellowLight23)
                    .frame(width: 138, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20.90701)
                            .inset(by: 0.46)
                            .stroke(Color(red: 0.89, green: 0.89, blue: 0.91), lineWidth: 0.92)
                        
                    )
            }
            Circle()
                .frame(height: 107)
                .foregroundColor(Color.YellowLight23)
            Circle()
                .frame(height: 94)
                .foregroundColor(Color.YellowNormal2)
            Circle()
                .frame(height: 71)
                .foregroundColor(Color.YellowDark2)
            Text("VS").font(.title).bold()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    LobbyPlayerName()
}
