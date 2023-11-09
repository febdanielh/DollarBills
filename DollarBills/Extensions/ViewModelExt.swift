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
    // MARK: Insert/Create
    func createInventoryItems(userID: String, itemID: String, qty: Int) async throws {
        let inventory = InventoryPayload(userID: userID, itemID: itemID, quantity: qty)
        try await Supabase.shared.createInventoryItem(item: inventory)
    }
    
    func createDuelRoomItems(roomID: String, roomOwner: String, inviteeID: String, duration: Double) async throws {
        let duelRoom = DuelRoomPayLoad(roomID: roomID, roomOwner: roomOwner, inviteeID: inviteeID, duration: duration)
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
    
    func createUser(username: String, points: Int) async throws {
        let userID = try await Supabase.shared.client.auth.session.user.id
        let userEmail = try await Supabase.shared.client.auth.session.user.email
        
        let user = UserPayload(id: userID, username: username, email: userEmail, points: points)
        
        try await Supabase.shared.createUserItems(item: user)
    }
    
    // MARK: Fetch/Read
    func fetchInventory(for userID: UUID) async throws {
        try await Supabase.shared.fetchInventoryItems(for: userID)
    }
    
    func fetchWorkout(for userID: UUID) async throws {
        try await Supabase.shared.fetchWorkoutItems(for: userID)
    }
    
    func fetchUserPoints(for userID: UUID) async throws{
        //        try await Supabase.shared.fetchUserPoints(for: userID)
        let user : [UserPayload] = try await Supabase.shared.client.database.from("User")
            .select(columns:"""
                            username,
                            points
                            """)
            .order(column: "points", ascending: false)
            .execute().value
        
        DispatchQueue.main.async {
            self.users = user
        }
    }
    
    func fetchUserPoint(for userID: UUID) async throws -> User {
        return try await Supabase.shared.fetchOwnPoint(for: userID)
    }
    
    func getUserPoint(for userID: UUID) async throws -> UserPayload {
        let userPoints: UserPayload = try await Supabase.shared.client.database.from("User").select().eq(column: "userID", value: userID).execute().value
        
        print(userPoints)
        return userPoints
    }
    
    // MARK: Delete
    
    
    // MARK: Update
    func updateUserPoints(points: Int) async throws {
        let userPoint = points
        try await Supabase.shared.updateUserPoints(points: userPoint)
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
