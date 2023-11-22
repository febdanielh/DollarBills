//
//  TimeLeft.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct TimeLeft: View {
    var body: some View {
        HStack {
            Text("Time Left")
                .font(.body)
            Spacer()
            Text("00:20,04")
                .font(.title3)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    TimeLeft()
}
