//
//  DuelAnimation.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct DuelAnimation: View {
    @State private var showOrangeCircle = false
    @State private var showRedCircle = false

    var body: some View {
        ZStack {
            
            if showRedCircle {
                Circle()
                    .foregroundColor(Color.red)
                    .frame(width: 230, height: 230)
            }
            
            if showOrangeCircle {
                Circle()
                    .foregroundColor(Color.orange)
                    .frame(width: 197, height: 197)
            }
            
            Circle()
                .foregroundColor(Color.yellow)
                .frame(width: 170, height: 170)
            
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    showOrangeCircle.toggle()
                }
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        showRedCircle.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    DuelAnimation()
}
