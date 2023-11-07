//
//  GIFImage.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct GIFImage: View {
    @State private var frameIndex: Int = 1
    private let totalFrames = 10 
    
    var body: some View {
        Image("frame\(frameIndex)")
            .resizable()
            .scaledToFit()
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                frameIndex = (frameIndex + 1) % totalFrames
            }
    }
}

#Preview {
    GIFImage()
}
