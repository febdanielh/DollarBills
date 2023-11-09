//
//  DollarBillsApp.swift
//  DollarBills
//
//  Created by Febrian Daniel on 27/09/23.
//

import SwiftUI

let NAME = "Furthr"
@main
struct DollarBillsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .environmentObject(NetworkMonitor())
                .preferredColorScheme(.light)
        }
    }
}
