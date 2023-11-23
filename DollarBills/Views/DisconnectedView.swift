//
//  DisconnectedView.swift
//  DollarBills
//
//  Created by Elvis Susanto on 08/11/23.
//

import SwiftUI

struct DisconnectedView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .foregroundStyle(.red)
                .padding()
            Text("No internet connection available.")
                .fontWeight(.semibold)
            Text("Please connect your phone to the internet and relaunch the application.")
        }
    }
}

#Preview {
    LeaderboardDetailView()
}

