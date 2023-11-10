//
//  SupaModel.swift
//  DollarBills
//
//  Created by Febrian Daniel on 07/11/23.
//

import Foundation

struct InventoryPayload: Codable {
    let userID: String
    let itemID: String
    let quantity: Int
}

struct DuelRoomPayLoad: Codable {
    let roomID: String
    let createdAt : Date
    let roomOwner : UUID
    var inviteeID : UUID?
    let duration : TimeInterval
    var startedAt : Date?
    var ownerReady : Bool = false
    var inviteeReady : Bool = false
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

struct UserPayload: Codable,/* Identifiable,*/ Hashable {
    var userID: String
    var username: String
    var email: String?
    var points: Int
    
//    enum CodingKeys: String, CodingKey {
//        case id = "userID"
//        case username
//        case email
//        case points
//    }
}

struct User: Decodable {
    var userID: String
    var username: String
    var email: String
    var points: Int
}
