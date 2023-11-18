//
//  ScrollViewDuel.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct ScrollViewDuel: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack (spacing: -10){
                ActiveItem()
                ActiveItem()
                ActiveItem()
            }
            
        }
    }
}

#Preview {
    ScrollViewDuel()
}
