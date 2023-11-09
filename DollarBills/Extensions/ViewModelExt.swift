//
//  ViewModelExt.swift
//  DollarBills
//
//  Created by Febrian Daniel on 06/11/23.
//

import Foundation
import Supabase
import AuthenticationServices
import GoTrue
import SwiftUI

extension ViewModel {
    
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
    
    // MARK: Insert/Create
    func createInventoryItems(userID: String, itemID: String, qty: Int) async throws {
        let inventory = InventoryPayload(userID: userID, itemID: itemID, quantity: qty)
        try await Supabase.shared.createInventoryItem(item: inventory)
    }
    
    func createDuelRoom(duration: TimeInterval) async throws {
        let ownerID = try await fetchUserID()
        let duelRoom = DuelRoomPayLoad(roomID: generateRandomCode(), createdAt: Date(), roomOwner: ownerID, duration: duration)
        try await Supabase.shared.createDuelRoomItem(item: duelRoom)
    }
    
    func createWorkoutItems(distance: Double, pace: Double, duration: Double) {
        let workout = WorkoutPayload(workoutID: nil, startDate: Date().description, endDate: Date().description, distance: distance, pace: pace, duration: duration)
        Task {
            try await Supabase.shared.createWorkoutItem(item: workout)
        }
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
    
    func fetchJoinDuelRoom(roomID: String) async throws -> String {
        return try await Supabase.shared.fetchJoinDuelRoom(for: roomID, for: fetchUserID())
    }
    
    func fetchUserID() async throws -> UUID {
        return try await Supabase.shared.client.auth.session.user.id
    }
    
    
    // MARK: Delete
    // MARK: Update
    
    // MARK: Sign In
    func signInApple(uid: String) async throws {
        try await Supabase.shared.client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: uid))
    }
    
    func isUserAuthenticated() async {
        do {
            _ = try await Supabase.shared.client.auth.session.user
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
    }
}
