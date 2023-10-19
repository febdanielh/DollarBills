//
//  SessionDelegator.swift
//  DollarBills Watch Watch App
//
//  Created by Angelica Pinonkuan on 18/10/23.
//

import Foundation
import WatchConnectivity
import MapKit

class SessionDelegator: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    @Published var receivedMessage = ""
    @Published var receivedRegion: MKCoordinateRegion?
//    @Published var receivedDistance: 
    
    
    
    init(session: WCSession = . default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        DispatchQueue.main.async {
//            self.receivedMessage
//            self.receivedMessage = message["message"] as? String ?? ""
//            print ("Received Message >" + self.receivedMessage)
//            UserDefaults.standard.set(self.receivedMessage, forKey: "message")
//            
//        }
//    }
    
//        func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
//            do {
//                if let region = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? MKCoordinateRegion {
//                    DispatchQueue.main.async {
//                        self.receivedRegion = region
//                        print("Received MKCoordinateRegion")
//                        // You can use the `receivedRegion` as needed in your watch app.
//                    }
//                } else {
//                    print("Received data is not a valid MKCoordinateRegion")
//                }
//            } catch {
//                print("Error decoding MKCoordinateRegion: \(error)")
//            }
//        }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
//        do {
//            let receivedObject = try JSONDecoder().decode(receivedRegion.self, from: messageData)
//            // Update your WatchOS ObservableObject with the received data
//            // For example:
////            watchObservableObject.update(with: receivedObject)
//            UserDefaults.standard.set(self.receivedRegion, forKey: "region")
//        } catch {
//            // Handle decoding errors
//        }
    }
    
    
}
