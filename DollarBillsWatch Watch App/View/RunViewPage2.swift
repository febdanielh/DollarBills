//
//  RunViewPage2.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunViewPage2: View {
    
    @State private var ItemReceived = true
    
    var body: some View {
//        GIFImage()
        ScrollView {
            VStack {
                if ItemReceived  {
                    ItemProgress()
                        .frame(width: 10, height: 10, alignment: .topLeading)
                        .padding(.leading, 30)
                        .padding(.top, -30)
                }
                GIFImage()
                RunViewPage2Directions()
            }
        }
    }
}

#Preview {
    RunViewPage2()
}
