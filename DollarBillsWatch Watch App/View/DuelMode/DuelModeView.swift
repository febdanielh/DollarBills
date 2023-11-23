//
//  DuelModeView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct DuelModeView: View {
    @EnvironmentObject var wtp: WatchToPhone
    @State private var p1Win = true
    @State private var p2Win = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if wtp.timeRemaining > 0 {
            VStack {
                TimeLeft()
                    .padding(.top, -40)
                Player(p1Win: $p1Win, p2Win: $p2Win)
                    .padding(.vertical)
                ScrollViewDuel()
                    .padding(.bottom, -20)
            }
            .onReceive(timer, perform: { _ in
                if wtp.timeRemaining > 0 {
                    wtp.timeRemaining -= 1
                } else {
                    print("countdown finished")
                }
            })
        } else {
            ResultView()
        }
    }
}

#Preview {
    DuelModeView()
}
