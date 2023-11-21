//
//  RunViewTab.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

enum RunTab {
    case controlView
    case mainView
    case metricsView
    case runMapView
}

struct RunViewTab: View {
    @State var selection: RunTab = .mainView
    @StateObject var locationManager = LocationManager()
        var body: some View {
            TabView(selection: $selection) {
                ControlView(tab: $selection)
                    .tag(RunTab.controlView)
//                VerticalTabView()
                RunMainView()
                    .tag(RunTab.mainView)
                RunMetricsView()
                    .tag(RunTab.metricsView)
                RunMapView()
                    .tag(RunTab.runMapView)
            }
            .onAppear {
                locationManager.checkServiceAvailability()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//            .gesture(
//                DragGesture()
//                    .onEnded { value in
//                        if value.translation.width < 0 {
//                            // Swipe left
//                            currentPage = min(currentPage + 1, 3)
//                        } else if value.translation.width > 0 {
//                            // Swipe right
//                            currentPage = max(currentPage - 1, 0)
//                        }
//                    }
//            )
        }
}

#Preview {
    RunViewTab()
}
