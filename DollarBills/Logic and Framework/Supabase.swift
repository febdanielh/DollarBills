//
//  Supabase.swift
//  DollarBills
//
//  Created by Febrian Daniel on 06/11/23.
//

import Foundation
import Supabase

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
    
    // MARK: Fetch/Read
    func fetchInventoryItems(for userID: String) async throws {
        let response : [InventoryPayload] = try await client.database.from("Inventory").execute().value
        print(response)
    }
    
    func fetchWorkoutItems(for userID: String) async throws {
        let response : [WorkoutPayload] = try await client.database.from("Workout").execute().value
        print(response)
    }
    
    // MARK: Delete
    // MARK: Update
}
