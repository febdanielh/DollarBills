//
//  WatchToPhone.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 09/11/23.
//

import SwiftUI
import WatchConnectivity

class WatchToPhone: NSObject, ObservableObject {
    
    @Published var selectedItems: [Items] = []
    @Published var opponentName: String = ""
    @Published var timeRemaining: TimeInterval = 0.0
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func sendFinishWorkoutMessageToWatch () {
        //        woPayload: WorkoutPayload
        //        let message = ["ended" : woPayload]
        let message = ["ended" : "ended"]
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error when sending the message with error: \(error.localizedDescription)")
            }
            session.activate()
            print("Watch session activated")
        } else {
            print("WC Session not supported")
        }
        
        print("finished workout from watch")
    }
    
    func sendItemMessageToPhone(itemName: String) {
        let message = ["Message": itemName]
        if (WCSession.default.isReachable) {
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error when sending the message with error: \(error.localizedDescription)")
            }
            print("execute \(itemName) send message")
        }
    }
    
    @Published var watchDuration = "--"
    @Published var watchDistance = "--"
    @Published var watchPace = "--"
    @Published var heartRate = "--"
    @Published var avgHeartRate = "--"
    @Published var watchActiveEnergy = "--"
    @Published var watchElevation = "--"
    
    var wDuration = 0.0
    var wDistance = 0.0
    var wPace = 0.0
    var wHeartRate = "--"
    var wAvgHR = "--"
    var wActiveEnergy = "--"
    var wElevation = "--"
    
    func formattedDuration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: wDuration) ?? "00:00"
    }
    
    func formattedDistance() -> String {
        let distanceInKilometers = Measurement(value: wDistance, unit: UnitLength.meters).converted(to: .kilometers).value
        let formattedDistance = String(format: "%.2f km", distanceInKilometers)
        return formattedDistance
    }
    
    func formattedPace() -> String {
        guard wDistance > 0, wDuration > 0 else {
            return "N/A"
        }
        
        let paceValue = wDuration / 60 / wDistance * 1000 // Convert distance to kilometers
        let paceMinutes = Int(paceValue)
        let paceSeconds = Int((paceValue - Double(paceMinutes)) * 60)
        
        return String(format: "%d'%02d\"", paceMinutes, paceSeconds)
    }
    
    
    func updateUI() {
        print("update UI Called")
        watchDuration = formattedDuration()
        watchDistance = formattedDistance()
        watchPace = formattedPace()
        heartRate = wHeartRate
        avgHeartRate = wAvgHR
        watchActiveEnergy = wActiveEnergy
        watchElevation = wElevation
        
    }
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
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        DispatchQueue.main.async {
            guard let message = try? JSONDecoder().decode([Items].self, from: messageData) else {
                return
            }
            self.selectedItems = message
            
            print(self.selectedItems)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let timeValue = message["timeRemaining"] as? Double {
            timeRemaining = timeValue
        } else if let opNameValue = message["opponentName"] as? String {
            opponentName = opNameValue
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message coming through")
                
                wDuration = message["duration"]! as? Double ?? 0.0
                wDistance = message["distance"]! as? Double ?? 0.0
//                wPace = message["pace"]! as? Double ?? 0.0
        //        wHeartRate = message["heartRate"]! as? String ?? "--"
                
                print("Watch received: \(wDuration), \(wDistance), \(wPace), \(wHeartRate)")
    }
}
