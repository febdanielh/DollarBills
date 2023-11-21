//
//  DuelItem.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct DuelItem: View {
    var body: some View {
        ZStack {
            ActiveItem()
            ItemStatus()
        }
    }
}

#Preview {
    DuelItem()
}

struct ActiveItem: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 95, height: 95)
                .background(Color(red: 1, green: 0.98, blue: 0.90))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.50)
                        .stroke(Color(red: 0.90, green: 0.81, blue: 0.32), lineWidth: 0.50)
                )
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                )
            Image("itemRock")
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
        }
    }
}
