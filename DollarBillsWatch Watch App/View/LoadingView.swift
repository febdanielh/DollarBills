//
//  LoadingView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var showGIF = true
    
    var body: some View {
        NavigationView {
            ZStack {
                if showGIF {
                    GIFImage()
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                withAnimation {
                                    showGIF = false
                                }
                            }
                        }
                }
                
                if !showGIF {
                    LandingPageView()
                }
            }
        }
    }
}


#Preview {
    LoadingView()
}
