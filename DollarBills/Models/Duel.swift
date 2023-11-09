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
    @Published var duelTime: Double = 0.0
    @Published var carriedItems: [Items] = []
    @Published var usedItems: [Items] = []
    @Published var roomCode: String = ""
    
    var isPaused: Bool = false
    
    func createRoom(roomCode: String, creatorUserID: String, inviteeID: String, duration: Double) -> DuelRoomPayLoad {
        let roomData = DuelRoomPayLoad(roomID: roomCode, roomOwner: creatorUserID, inviteeID: inviteeID, duration: duration)
        
        return roomData
    } //perlu ga perlu nih soalnya udah ada query buat create duel room
    
    func joinRoom(roomCode: String, userID: String) {
        let searchRoom = Supabase.shared.client.database.from("DuelRoom")
        let room = searchRoom.select().equals(column: "roomID", value: roomCode)
        Task {
            do {
                let response = try await room.execute()
                if response.underlyingResponse.statusCode == 200 {
                    print("Room with code \(roomCode) exists. Entering room...")
                } else {
                    print("Room with code \(roomCode) does not exist.")
                }
            } catch {
                print("Error retrieving room: \(error)")
            }
        }
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
