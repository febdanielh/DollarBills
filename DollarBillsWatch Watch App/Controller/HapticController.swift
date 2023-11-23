//
//  HapticController.swift
//  DollarBillsWatch Watch App
//
//  Created by Febrian Daniel on 24/11/23.
//

import Foundation
import WatchKit

class HapticManager: ObservableObject {
    static let shared = HapticManager()

    func playHaptic() {
        WKInterfaceDevice.current().play(.success)
    }
}
