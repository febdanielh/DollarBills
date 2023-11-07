//
//  Countdown.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct Countdown: View {
    @State private var frameIndex: Int = 1
    private let totalFrames = 5
    
    var body: some View {
        Image("countdown\(frameIndex)")
            .resizable()
            .scaledToFit()
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                frameIndex = (frameIndex + 1) % totalFrames
            }
    }
}

#Preview {
    Countdown()
}
