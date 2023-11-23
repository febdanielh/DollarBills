//
//  PhoneToWatch.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 09/11/23.
//

import SwiftUI
import WatchConnectivity

var statisticsData: [String:Double] = [:]
class PhoneToWatch: NSObject, ObservableObject {
    @EnvironmentObject var vm: ViewModel
    
    @Published var isRunning: Bool = false
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func activateSession() {
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            if session.isReachable {
                print("WC session not yet reachable")
            }
            session.activate()
            print("Watch session activated")
        } else {
            print("WC Session not supported")
        }
    }
    
    func sendMessageToWatch() {
        print("halo")
        let message = ["Message": "Start Workout"]
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error when sending the message with error: \(error.localizedDescription)")
            }
            print("startWatchWorkout send message")
        }
    }
    
    func sendStartMatchMessageToWatch() {
        let message = ["Message": "Start Match"]
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error when sending the message with error: \(error.localizedDescription)")
            }
            print("start duel send message")
        }
    }
    
    func sendMessageToWatch(message: Dictionary<String, Double>) {
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage(message as [String : Any], replyHandler: nil) { error in
                print("Error when sending the message with error: \(error.localizedDescription)")}
        }
        print("sendMessageToWatch called")
    }
    
    func sendStatisticsData() {
        sendMessageToWatch(message: statisticsData)
    }
}

extension PhoneToWatch: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
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
        if (message.first?.key == "ended") {
            print("workout ended on phone aswellll")
            isRunning = false
            Task {
                try await vm.endWorkout()
            }
        }
    }
    
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        print("Received message from Watch")
//        wDistance = message["distance"]! as! String
//        wHeartRate = message["heartRate"]! as! String
//        wAvgHR = message["averageHeartRate"]! as! String
//        wActiveEnergy = message["activeEnergy"]! as! String
//        wElevation = message["elevation"]! as! String
//        
//        print(wDistance)
//        print(wHeartRate)
//        print(wAvgHR)
//        print(wActiveEnergy)
//    }
}
