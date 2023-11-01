//
//  RunViewPage2Tab.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI
import UIKit
import Foundation

struct RunViewPage2Tab: View {
    @State private var currentPage = 0
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                VStack(spacing: 0) {
                    RunViewPage2()
                        .id(0)
                    RunViewPage2Directions()
                        .id(1)
                    RunViewPage4()
                        .id(2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: -CGFloat(currentPage) * WKInterfaceDevice.current().screenBounds.size.height)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height < -50, currentPage > 0 {
                                withAnimation {
                                    currentPage -= 1
                                }
                                scrollView.scrollTo(currentPage)
                            } else if value.translation.height > 50, currentPage < 2 {
                                withAnimation {
                                    currentPage += 1
                                }
                                scrollView.scrollTo(currentPage)
                            }
                        }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    RunViewPage2Tab()
}
