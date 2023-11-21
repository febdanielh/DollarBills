//
//  ItemProgress.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct ItemProgress: View {
    @State private var progress: Double = 0.0
    let totalTime: Double = 20.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(Color.yellow, lineWidth: 5)
                    .frame(width: 42, height: 42)
                    .rotationEffect(.degrees(-90))

                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                Image("itemRock")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            .onAppear(perform: {
                startProgress()
            })
            .padding()

        }
    }

    func startProgress() {
        withAnimation(.linear(duration: totalTime)) {
            progress = 1.0
        }
    }
}

#Preview {
    ItemProgress()
}
