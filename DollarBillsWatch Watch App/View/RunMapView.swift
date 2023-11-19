//
//  RunMapView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunMapView: View {
    var body: some View {
        MapView()
            .ignoresSafeArea()
            .allowsHitTesting(false)
    }
}

#Preview {
    RunMapView()
}
