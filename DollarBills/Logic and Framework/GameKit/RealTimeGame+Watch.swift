//
//  RealTimeGame+Watch.swift
//  DollarBills
//
//  Created by Febrian Daniel on 20/11/23.
//

import Foundation
import GameKit
import WatchConnectivity

extension RealTimeGame: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func sendItemDataToWatch(item: [Items]) {
        guard let data = try? JSONEncoder().encode(item) else {
            return
        }
        WCSession.default.sendMessageData(data, replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("The session activation is failed with error: \(error.localizedDescription)")
        } else {
            print("The session has completed activation.")
        }
        
        if WCSession.default.isReachable {
            print("Reachable on Phone")
        } else {
            print("Not Reachable on Phone")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let value = message["Message"] as? String {
            print("message received")
            if (value == "Blue Potion") {
                takeActionBluePotion()
            } else if (value == "Red Potion") {
                takeActionRedPotion()
            } else if (value == "Rock") {
                takeAction3Rocks()
            } else if (value == "Bomb") {
                takeActionBomb()
            } else if (value == "White Flag") {
                takeActionWhiteFlag()
            }
        }
    }
}
