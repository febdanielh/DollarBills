//
//  TimeLeft.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct TimeLeft: View {
    @EnvironmentObject var wtp: WatchToPhone
    var body: some View {
        HStack {
            Text("Time Left")
                .font(.body)
            Spacer()
            Text("\(wtp.timeRemaining)")
                .font(.title3)
                .fontWeight(.semibold)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    TimeLeft()
}
