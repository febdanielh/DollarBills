//
//  ItemProgress.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct ItemProgress: View {
    @State private var progress: Double = 0.0
    let totalTime: Double = 10.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(Color.yellow, lineWidth: 10)
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(-90))

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
