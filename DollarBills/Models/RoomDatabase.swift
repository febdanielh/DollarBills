//
//  RoomDatabase.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import Foundation

class RoomDatabase {
    static var shared = RoomDatabase()

    private var rooms: [Room] = []

    func createRoom() -> Room {
        let randomCode = String(format: "%05d", Int.random(in: 0...99999))
        let room = Room(code: randomCode)
        rooms.append(room)
        return room
    }

    func getRoom(byCode code: String) -> Room? {
        return rooms.first { $0.code == code }
    }
}
