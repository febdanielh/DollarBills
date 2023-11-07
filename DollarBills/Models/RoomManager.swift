//
//  RoomManager.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import Foundation

class RoomManager: ObservableObject {
    @Published var rooms: [Room] = []
    @Published var isJoiningRoom = false
    @Published var roomToJoin: Room?
    
    func createRoom() {
        let room = RoomDatabase.shared.createRoom()
        rooms.append(room)
    }
    
    func joinRoom(with code: String) {
        if let room = RoomDatabase.shared.getRoom(byCode: code) {
            roomToJoin = room
            isJoiningRoom = true
        } else {
            // Handle the case where the room code does not exist
            print("Room with code \(code) not found")
        }
    }
}
