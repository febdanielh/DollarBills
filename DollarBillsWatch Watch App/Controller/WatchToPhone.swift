//
//  WatchToPhone.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 09/11/23.
//

import SwiftUI
import WatchConnectivity

class WatchToPhone: NSObject, ObservableObject {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
//    
//    func sendDataToPhone(message: Dictionary<String, String>) {
//        if (WCSession.default.isReachable) {
//            WCSession.default.sendMessage(message as [String :Any] , replyHandler: nil) { error in
//                print("Error when sending the message with error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func sendStatistics() {
//        sendDataToPhone(message: statisticsData)
//    }
}

extension WatchToPhone: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("The session activation is failed with error: \(error.localizedDescription)")
        } else {
            print("The session has completed activation on Watch.")
        }
        
        if WCSession.default.isReachable {
            print("Reachable on Watch")
        } else {
            print("Not Reachable on Watch")
        }
    }
}