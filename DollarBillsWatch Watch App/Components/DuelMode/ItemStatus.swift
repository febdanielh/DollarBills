//
//  ItemStatus.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct ItemStatus: View {
    @Binding var isSent: Bool
    var body: some View {
        ZStack {
            if isSent {
                SentView()
            } else {
                ExecuteView()
            }
        }
    }
}

#Preview {
    ItemStatus(isSent: .constant(true))
}

struct UsedView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 63, height: 17)
            .background(Color(red: 0.07, green: 0.85, blue: 0.38))
            .cornerRadius(10)
        Text("Used")
            .font(.caption2)
            .foregroundStyle(.black)
    }
}

struct SentView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 63, height: 17)
            .background(Color(red: 0.07, green: 0.85, blue: 0.38))
            .cornerRadius(10)
        Text("Sent")
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
    }
}

struct ExecuteView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 63, height: 17)
            .background(Color(red: 1, green: 0.31, blue: 0.31))
            .cornerRadius(10)
        Text("Execute")
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
    }
}

