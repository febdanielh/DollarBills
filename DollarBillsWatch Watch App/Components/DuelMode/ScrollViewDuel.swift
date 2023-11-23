//
//  ScrollViewDuel.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct ScrollViewDuel: View {
    @EnvironmentObject var wtp: WatchToPhone
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 5) {
                ForEach(wtp.selectedItems) { item in
                    DuelItem(item: item)
                }
            }
            
        }
    }
}

#Preview {
    ScrollViewDuel()
}
