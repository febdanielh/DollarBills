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
        let roomID = generateRandomCode()
        currentRoomID = roomID
        let duelRoom = DuelRoomPayLoad(roomID: roomID, createdAt: Date(), roomOwner: ownerID, duration: duration)
        try await Supabase.shared.createDuelRoomItem(item: duelRoom)
    }
    
    func createDuelRoom(duration: TimeInterval, name: String) async throws {
        let ownerID = try await fetchUserID()
        let roomID = generateRandomCode()
        currentRoomID = roomID
        let duelRoom = DuelRoomPayLoad(roomID: roomID, createdAt: Date(), roomOwner: ownerID, duration: duration)
        try await Supabase.shared.createDuelRoomItem(item: duelRoom)
    }
    
    func createWorkoutItems() async throws {
        let userIDNow = try await self.fetchUserID()
        
        let workout = WorkoutPayload(workoutID: nil, userID: userIDNow, startDate: .now, endDate: .now, distance: 0.0, pace: 0.0, duration: 0.0, routeName: selectedAnnotation.routeName)
        Task {
            try await Supabase.shared.createWorkoutItem(item: workout)
        }
    }
    
    func createDetailRoomItems(roomID: String, itemsCarried: [String], itemsUsed: [String], distance: Double, duration: Double, pace: Double, calorieBurned: Double, heartRate: Int, elevation: Double, userID: String) async throws {
        let detailRoom = DetailRoomPayload(roomID: roomID, itemsCarried: itemsCarried, itemsUser: itemsUsed, distance: distance, duration: duration, pace: pace, calorieBurned: calorieBurned, heartRate: heartRate, elevation: elevation, userID: userID)
        try await Supabase.shared.createDetailRoomItem(item: detailRoom)
    }
    
    func createUser(username: String, points: Int) async throws {
        let userID = try await Supabase.shared.client.auth.session.user.id.uuidString
        let userEmail = try await Supabase.shared.client.auth.session.user.email
        
        let user = UserPayload(userID: userID, username: username, points: points)
        
        try await Supabase.shared.createUserItems(item: user)
    }
    
    // MARK: Fetch/Read
    func fetchInventory(for userID: UUID) async throws {
        try await Supabase.shared.fetchInventoryItems(for: userID)
    }
    
    func fetchWorkout(for userID: UUID) async throws {
        try await Supabase.shared.fetchWorkoutItems(for: userID)
    }
    
    func fetchUserPoints() async throws {
        let user : [User] = try await Supabase.shared.client.database.from("User")
            .select()
            .order(column: "points", ascending: false)
            .execute().value
        
        DispatchQueue.main.async {
            self.users = user
        }
    }
    
    func fetchUserPoint(for userID: UUID) async throws -> [User] {
        return try await Supabase.shared.fetchOwnPoint(for: userID)
    }
    
    func fetchJoinDuelRoom(roomID: String) async throws -> String {
        return try await Supabase.shared.fetchJoinDuelRoom(for: roomID, for: fetchUserID())
    }
    
    func fetchOwnerName(roomID: String) async throws -> String {
        return try await Supabase.shared.fetchOwnerName(for: roomID)
    }
    
    func fetchUserName(userID: UUID) async throws -> String {
        return try await Supabase.shared.fetchUserName(for: userID)
    }
    
    func fetchCurrentUserName() async throws -> String {
        let userID = try await fetchUserID()
        return try await Supabase.shared.fetchCurrentUserName(for: userID)
    }
    
    func fetchUserID() async throws -> UUID {
        return try await Supabase.shared.client.auth.session.user.id
    }
    
    func fetchDetailRoom(for roomID: String) async throws {
        let detailRoom = try await Supabase.shared.fetchDetailDuel(for: roomID)
        
        DispatchQueue.main.async {
            self.detailRoom = detailRoom
        }
    }
    
    func fetchWorkouts() async throws -> [WorkoutReadPayload] {
        
        let userID = try await fetchUserID()
        let returningWorkouts = try await Supabase.shared.fetchCurrentUserWorkouts(for: userID)
        return returningWorkouts
        
    }
    
    // MARK: Delete
    
    
    // MARK: Update
    func updateUserPoints(points: Int) async throws {
        let userPoint = points
        try await Supabase.shared.updateUserPoints(points: userPoint)
    }
    
    func updateWorkoutItems(distance: Double, pace: Double, duration: Double) async throws {
        let userIDNow = try await fetchUserID()
        let itemNames: [String] = getItemNames()
        let item = WorkoutUpdatePayload(workoutID: nil, userID: nil, startDate: nil, endDate: .now, distance: distance, pace: pace, duration: duration, itemName: itemNames)
        try await Supabase.shared.updateWorkoutItems(item: item, uid: userIDNow)
    }
    
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
