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
                RunMainView()
                RunDirectionView()
            }.tabViewStyle(.carousel)
        }
    }
}

#Preview {
    VerticalTabView()
}
