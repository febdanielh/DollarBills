//
//  DuelModeView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct DuelModeView: View {
    
    @State private var p1Win = true
    @State private var p2Win = false
    
    
    var body: some View {
        VStack(){
            TimeLeft()
                .padding(.top, -40)
            Player(p1Win: $p1Win, p2Win: $p2Win)
                .padding(.vertical)
            ScrollViewDuel()
                .padding(.bottom, -20)
        }
    }
}

#Preview {
    DuelModeView()
}
