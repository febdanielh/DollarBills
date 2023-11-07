//
//  ViewModelExt.swift
//  DollarBills
//
//  Created by Febrian Daniel on 06/11/23.
//

import Foundation
import Supabase

extension ViewModel {
    // MARK: Insert/Create
    func createInventoryItems(userID: String, itemID: String, qty: Int) async throws {
        let inventory = InventoryPayload(userID: userID, itemID: itemID, quantity: qty)
        try await Supabase.shared.createInventoryItem(item: inventory)
    }
    
    func createDuelRoomItems(roomID: String, roomOwner: String, inviteeID: String, duration: Double) async throws {
        let duelRoom = DuelRoomPayLoad(roomID: roomID, roomOwner: roomOwner, inviteeID: inviteeID, duration: duration)
        try await Supabase.shared.createDuelRoomItem(item: duelRoom)
    }
    
    func createWorkoutItems(distance: Double, pace: Double, duration: Double) async throws {
        let workout = WorkoutPayload(distance: distance, pace: pace, duration: duration)
        try await Supabase.shared.createWorkoutItem(item: workout)
    }
    
    func createDetailRoomItems(roomID: String, itemsCarried: [String], itemsUsed: [String], distance: Double, duration: Double, pace: Double, calorieBurned: Double, heartRate: Int, elevation: Double, userID: String) async throws {
        let detailRoom = DetailRoomPayload(roomID: roomID, itemsCarried: itemsCarried, itemsUser: itemsUsed, distance: distance, duration: duration, pace: pace, calorieBurned: calorieBurned, heartRate: heartRate, elevation: elevation, userID: userID)
        try await Supabase.shared.createDetailRoomItem(item: detailRoom)
    }
    
    // MARK: Fetch/Read
    func fetchInventory(for userID: String) async throws {
        try await Supabase.shared.fetchInventoryItems(for: userID)
    }
    
    func fetchWorkout(for userID: String) async throws {
        try await Supabase.shared.fetchWorkoutItems(for: userID)
    }
    // MARK: Delete
    // MARK: Update
}