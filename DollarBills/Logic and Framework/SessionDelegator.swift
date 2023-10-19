//
//  SessionDelegator.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 18/10/23.
//

import Foundation
import WatchConnectivity

class SessionDelegator: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = . default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
       
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}
