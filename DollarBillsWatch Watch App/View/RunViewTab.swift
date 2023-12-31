//
//  RunViewTab.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunViewTab: View {
    @State private var currentPage = 1

        var body: some View {
            TabView(selection: $currentPage) {
                ControlView()
                    .tag(0)
                VerticalTabView()
                    .tag(1)
                RunMetricsView()
                    .tag(2)
                RunMapView()
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            // Swipe left
                            currentPage = min(currentPage + 1, 3)
                        } else if value.translation.width > 0 {
                            // Swipe right
                            currentPage = max(currentPage - 1, 0)
                        }
                    }
            )
        }
}

#Preview {
    RunViewTab()
}
