//
//  VerticalTabView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 01/11/23.
//

import SwiftUI

struct VerticalTabView: View {
    
    var body: some View {
        GeometryReader { proxy in
            TabView{
                RunViewPage2()
                RunViewPage2Directions()
            }.tabViewStyle(.carousel)
        }
    }
}

#Preview {
    VerticalTabView()
}
