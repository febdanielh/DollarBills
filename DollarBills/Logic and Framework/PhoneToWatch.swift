//
//  PhoneToWatch.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 09/11/23.
//

import SwiftUI
import WatchConnectivity

class PhoneToWatch: NSObject, ObservableObject {
    
    @Published var isRunning: Bool = true
    
//    @Published var watchDuration = "--"
//    @Published var watchDistance = "--"
//    @Published var watchPace = "--"
//    @Published var heartRate = "--"
//    @Published var avgHeartRate = "--"
//    @Published var watchActiveEnergy = "--"
//    @Published var watchElevation = "--"
//
//    var wDuration = "--"
//    var wDistance = "--"
//    var wPace = "--"
//    var wHeartRate = "--"
//    var wAvgHR = "--"
//    var wActiveEnergy = "--"
//    var wElevation = "--"
//    
//    func updateUI() {
//        print("update UI Called")
//        watchDuration = wDuration
//        watchDistance = wDistance
//        watchPace = wPace
//        heartRate = wHeartRate
//        avgHeartRate = wAvgHR
//        watchActiveEnergy = wActiveEnergy
//        watchElevation = wElevation
//        
//    }
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendMessageToWatch() {
        print("haloo")
        isRunning = true
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
            print("workout ended on phone aswell")
            isRunning = false
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
