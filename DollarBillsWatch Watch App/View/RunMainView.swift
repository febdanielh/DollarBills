//
//  RunMainView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunMainView: View {
    
    @State private var ItemReceived = true
    
    var body: some View {
            VStack {
                if ItemReceived  {
                    ItemProgress()
                        .frame(width: 10, height: 10, alignment: .topLeading)
                        .padding(.leading, -70)
                        .padding(.top, -20)
                }
                GIFImage()
            }
    }
}

#Preview {
    RunMainView()
}
