//
//  CountdownView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct CountdownView: View {
    
    @State private var showCountdown = true
    
    var body: some View {
        ZStack {
            if showCountdown {
                Countdown()
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                            withAnimation {
                                showCountdown = false
                            }
                        }
                    }
            }
            
            if !showCountdown {
                RunViewTab()
            }
        }
    }
}

#Preview {
    CountdownView()
}
