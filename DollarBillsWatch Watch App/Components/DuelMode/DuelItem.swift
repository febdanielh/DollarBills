//
//  DuelItem.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct DuelItem: View {
    
    @State var isTap = false
    @State var isSent = false
    @State var isDisabled = false
    
    @EnvironmentObject var watchToPhone: WatchToPhone
    
    var body: some View {
        ZStack {
            ActiveItem()
                .onTapGesture {
                    isTap.toggle()
                }
            if isTap {
                ItemStatus(isSent: $isSent)
                    .onTapGesture {
//                        watchToPhone.sendMessageToPhone(itemName: "Blue Potion")
                        isSent = true
                        isDisabled = true
                    }
            }
        }.disabled(isDisabled)
    }
}

#Preview {
    DuelItem()
}

struct ActiveItem: View {
//    let imageName: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 95, height: 95)
                .foregroundColor(Color(red: 1, green: 0.98, blue: 0.90))
                .cornerRadius(15)
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 0.90, green: 0.81, blue: 0.32), lineWidth: 0.50)
                )
            Image("3Rock") //imageName
                .resizable()
                .frame(width: 120, height: 88)
        }
    }
}

struct InactiveItem: View {
    var body: some View {
        ZStack {
            ActiveItem()
            Rectangle()
                .frame(width: 95, height: 95)
                .cornerRadius(15)
                .foregroundColor(.gray)
                .opacity(0.8)
        }.disabled(true)
    }
}
