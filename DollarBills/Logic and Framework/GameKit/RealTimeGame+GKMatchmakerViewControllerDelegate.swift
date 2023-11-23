/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 An extension for real-time games that handles matchmaker view controller delegate callbacks.
 */

import Foundation
import GameKit
import SwiftUI

extension RealTimeGame: GKMatchmakerViewControllerDelegate {
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        // Dismiss the view controller.
        viewController.dismiss(animated: true) { }
        
        matchData["timeRemaining"] = timeRemaining
        matchData["opponentName"] = opponentName
        
        // Start the game with the player.
        if !playingGame && match.expectedPlayerCount == 0 {
            startMyMatchWith(match: match, time: timeRemaining)
            sendStartMatchMessageToWatch()
            sendItemDataToWatch(item: myItems)
            sendMatchDataToWatch(matchData: matchData)
            print(myItems)
            print("started")
        }
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}
