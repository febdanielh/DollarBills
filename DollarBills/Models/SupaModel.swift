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
    let roomOwner: String
    let inviteeID: String
    let duration: Double
}

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
    let distance: Double
    let pace: Double
    let duration: Double
}
