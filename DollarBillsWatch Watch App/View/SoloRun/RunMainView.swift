//
//  RunMainView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunMainView: View {
    @EnvironmentObject var wtp: WatchToPhone
    @State var ItemReceived: Bool = false
    @State var itemImage: String = "itemRock"
    @State var isGif: Bool = true
    var body: some View {
        VStack {
            if isGif {
                GIFImage()
            } else {
                ItemProgress(item: itemImage)
                //                    .frame(width: 10, height: 10, alignment: .topLeading)
                //                    .padding(.leading, 70)
                //                    .padding(.top, -20)
            }
        }
        .onReceive(wtp.$receivedItem) { item in
            if let lastItem = item.last {
                itemImage = lastItem.image
                isGif = false
                print(isGif)
            }
            HapticManager.shared.playHaptic()
        }
        .onAppear {
            HapticManager.shared.playHaptic()
        }
    }
}

#Preview {
    RunMainView()
}
