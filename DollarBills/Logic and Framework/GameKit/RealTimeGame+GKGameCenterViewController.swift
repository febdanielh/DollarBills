/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An extension for real-time games that handles Game Center view controller delegate callbacks.
*/

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame {
    
    /// Cleans up the view's state when the local player closes the dashboard.
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        // Dismiss the view controller.
        gameCenterViewController.dismiss(animated: true)
    }
}
