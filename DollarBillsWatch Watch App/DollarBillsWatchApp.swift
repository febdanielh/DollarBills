//
//  DollarBillsWatchApp.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 27/10/23.
//

import SwiftUI

@main
struct DollarBillsWatch_Watch_AppApp: App {
    @ObservedObject var watchToPhone = WatchToPhone()
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(WorkoutManager(watchSession: watchToPhone.session))
        }
    }
}
