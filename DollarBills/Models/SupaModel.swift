//
//  SupaModel.swift
//  DollarBills
//
//  Created by Febrian Daniel on 07/11/23.
//

import Foundation

struct InventoryPayload: Codable {
    var userID: String
    var itemID: String
    var quantity: Int
}

struct DuelRoomPayLoad: Codable {
    var roomID: String
    var createdAt : Date
    var roomOwner : UUID
    var inviteeID : UUID?
    var duration : TimeInterval
    var startedAt : Date?
    var ownerReady : Bool = false
    var inviteeReady : Bool = false
}

struct DuelRoom: Decodable {
    var roomID: String
    var createdAt : Date
    var duration : TimeInterval
    var roomOwner : UUID
    var inviteeID : UUID?
    var startedAt : Date?
    var inviteeReady : Bool
}

//struct DuelRoomDTO: Codable {
//    init(inviteeID: UUID) {
//        self.inviteeID = inviteeID
//    }
//}

struct DetailRoomPayload: Codable {
    let roomID: String
    let itemsCarried: [String]
    let itemsUser: [String]
    let distance: Double
    let duration: Double
    let pace: Double
    let calorieBurned: Double
    let heartRate: Int
    let elevation: Double
    let userID: String
}

struct WorkoutPayload: Codable {
    let workoutID: UUID?
    let startDate: String
    let endDate: String
    let distance: Double
    let pace: Double
    let duration: Double
}

struct UserPayload: Codable {
    var userID: String
    var username: String
    var points: Int
}

struct User: Decodable, Hashable {
    var userID: String
    var username: String
    var points: Int
}
