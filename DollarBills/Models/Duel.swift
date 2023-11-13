//
//  Duel.swift
//  DollarBills
//
//  Created by Febrian Daniel on 05/11/23.
//

import Foundation
import HealthKit
import CoreLocation
import Supabase

class Duel: NSObject, ObservableObject { //ini masih cobacoba
    
    @Published var roomID: String
    @Published var createdAt : Date
    @Published var roomOwner : UUID
    @Published var inviteeID : UUID?
    @Published var duration : TimeInterval
    @Published var startedAt : Date?
    @Published var ownerReady : Bool
    @Published var inviteeReady : Bool
    
    init(roomID: String, createdAt: Date = Date(), roomOwner: UUID, duration: TimeInterval) {
        self.roomID = roomID
        self.createdAt = createdAt
        self.roomOwner = roomOwner
        self.inviteeID = nil
        self.duration = duration
        self.startedAt = nil
        self.ownerReady = false
        self.inviteeReady = false
    }
    
}
