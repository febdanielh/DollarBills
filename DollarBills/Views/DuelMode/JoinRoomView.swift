//
//  JoinRoomView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct JoinRoomView: View {
    @Binding var isPopoverPresented: Bool
    @Binding var enteredCode: String
    
    var body: some View {
        VStack {
            TextField("Enter a room code", text: $enteredCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 328, height: 60)
                .cornerRadius(15)
                .padding()
            
            Button(action: {
                isPopoverPresented = false
                // Handle joining the room here
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 326, height: 60)
                        .foregroundStyle(Color.black)
                    Text("Join Room")
                        .foregroundColor(Color.white)
                        .font(.title3)
                }
            })
        }
        .padding()
    }
}
