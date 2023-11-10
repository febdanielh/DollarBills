//
//  Supabase.swift
//  DollarBills
//
//  Created by Febrian Daniel on 06/11/23.
//

import Foundation
import Supabase
import SwiftUI

class Supabase {
    
    static let shared = Supabase()
    
    private init(){}
    
    lazy var client = SupabaseClient(supabaseURL: SupaExt.supabaseURL, supabaseKey: SupaExt.supabaseKey)
    
    
    // MARK: Inserts
    func createInventoryItem(item: InventoryPayload) async throws {
        let response = client.database.from("Inventory").insert(values: item)
        
        Task {
            try await response.execute()
        }
    }
    
    func createDuelRoomItem(item: DuelRoomPayLoad) async throws {
        let response = client.database.from("DuelRoom").insert(values: item)
        
        Task {
            try await response.execute()
        }
    }
    
    func createWorkoutItem(item: WorkoutPayload) async throws {
        Task {
            let response = client.database.from("Workout").insert(values: item).single()
            do {
                try await response.execute()
            } catch {
                print(error)
            }
        }
    }
    
    func createDetailRoomItem(item: DetailRoomPayload) async throws {
        let response = client.database.from("DetailRoom").insert(values: item)
        
        Task {
            try await response.execute()
        }
    }
    
    func createUserItems(item: UserPayload) async throws {
        let response = client.database.from("User").insert(values: item)
        
        Task {
            try await response.execute()
        }
    }
    
    // MARK: Fetch/Read
    func fetchInventoryItems(for userID: UUID) async throws {
        let response = try await client.database.from("Inventory").select().eq(column: "userID", value: userID).execute()
        print(response)
    }
    
    func fetchWorkoutItems(for userID: UUID) async throws {
        let response : [WorkoutPayload] = try await client.database.from("Workout").execute().value
        print(response)
    }
    
    func fetchOwnPoint(for userID: UUID) async throws -> [User] {
        let response = try await client.database.from("User").select().eq(column: "userID", value: userID).execute()
        let data = response.underlyingResponse.data
        
        let decoder = JSONDecoder()
        let userData = try decoder.decode([User].self, from: data)
        
        print(userData)
        return userData
    }
    
    // MARK: Delete
    // MARK: Update
    func updateUserPoints(points: Int) async throws {
        let id = try await client.auth.session.user.id
        
        let response = client.database.from("User").update(values: points).eq(column: "userID", value: id)
        
        Task {
            try await response.execute()
        }
    }
}
