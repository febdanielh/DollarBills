//
//  LoadingAnimation.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct LoadingAnimation: View {
    @State private var dotOpacity: Double = 1.0
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.black)
                .opacity(dotOpacity)
                .frame(width: 10, height: 10)
            Circle()
                .fill(Color.black)
                .opacity(dotOpacity)
                .frame(width: 10, height: 10)
            Circle()
                .fill(Color.black)
                .opacity(dotOpacity)
                .frame(width: 10, height: 10)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                dotOpacity = 0.2
            }
        }
    }
}

#Preview {
    LoadingAnimation()
}
