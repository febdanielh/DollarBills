//
//  Duel.swift
//  DollarBills
//
//  Created by Febrian Daniel on 05/11/23.
//

import Foundation
import HealthKit
import CoreLocation

class Duel: NSObject, ObservableObject { //ini masih cobacoba
    
    @Published var duelTime: Double = 0.0
    @Published var carriedItems: [Items] = []
    @Published var usedItems: [Items] = []
    @Published var roomCode: String = ""
    
    var isPaused: Bool = false
    
    func createRoom(roomCode: String, creatorUserID: String) {
        let roomData = [
            "roomCode": roomCode,
            "creatorUserID": creatorUserID,
        ]
//        let roomsRef = Database.database().reference().child("rooms")
//        roomsRef.child(roomCode).setValue(roomData)m
    }

    // Join an existing room using room code
    func joinRoom(roomCode: String, userID: String) {
        /*
         let roomsRef = Database.database().reference().child("rooms")
        roomsRef.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.hasChild(roomCode) {
            } else {
            }
        })
         */
    }
    
    func generateRandomCode() -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomCode = ""
        for _ in 0..<4 {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomCode.append(character)
        }
        return randomCode
    }
    
}
