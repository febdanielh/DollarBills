//
//  CreateRoomView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct CreateRoomView: View {
    
    
    
    var body: some View {
        VStack {
            Text("Monday, 15 October 2023")
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 160, height: 36)
                    .foregroundColor(Color.yellow)
                Text("Choose Duration")
            }
            .padding(.top, 20)
            
            
            TimePickerView()
                .padding(.top, 150)
            
            NavigationLink {
                LobbyView()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 326, height: 60)
                        .foregroundStyle(Color.black)
                    Text("Create Room")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                }
            }
            .padding(.top, 80)
        }
    }
}

#Preview {
    CreateRoomView()
}
