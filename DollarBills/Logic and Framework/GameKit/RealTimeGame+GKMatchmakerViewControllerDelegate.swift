/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 An extension for real-time games that handles matchmaker view controller delegate callbacks.
 */

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKMatchmakerViewControllerDelegate {
    /// Dismisses the matchmaker interface and starts the game when a player accepts an invitation.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        // Dismiss the view controller.
        viewController.dismiss(animated: true) { }
        
//        isConnected = true
//        myMatch = match
        
        // Start the game with the player.
        if !playingGame && match.expectedPlayerCount == 0 {
            startMyMatchWith(match: match, time: timeRemaining)
            sendItemDataToWatch(item: myItems)
            print(myItems)
            print("started")
        }
    }
    
    /// Dismisses the matchmaker interface when either player cancels matchmaking.
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    /// Reports an error during the matchmaking process.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}
