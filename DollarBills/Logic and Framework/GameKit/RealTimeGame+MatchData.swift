/*
See LICENSE folder for this sample’s licensing information.

Abstract:
An extension for real-time games that handles data that the game sends between players.
*/

import Foundation
import GameKit
import SwiftUI

// MARK: Game Data Objects

struct GameData: Codable {
    var matchName: String
    var playerName: String
    var timeRemaining: TimeInterval?
    var score: Int?
    var itemUsed: String?
    var outcome: String?
    var distance: Double?
}

extension RealTimeGame {
    
    // MARK: Codable Game Data
    
    /// Creates a data representation of the local player's score for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the score.
    func encode(timeRemaining: TimeInterval) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, timeRemaining: timeRemaining, itemUsed: nil, outcome: nil)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of the local player's score for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the distance
    func encode(distance: Double) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, outcome: nil, distance: distance)
        return encode(gameData: gameData)
    }
    
    
    ///send data to affect opponent's distance
    func encodeOpponent(distance: Double, item: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: opponentName, itemUsed: item, outcome: nil, distance: distance)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of the game outcome for sending to other players.
    ///
    /// - Returns: A representation of game data that contains only the game outcome.
    func encode(outcome: String) -> Data? {
        let gameData = GameData(matchName: matchName, playerName: GKLocalPlayer.local.displayName, score: nil, itemUsed: nil, outcome: outcome)
        return encode(gameData: gameData)
    }
    
    /// Creates a data representation of game data for sending to other players.
    ///
    /// - Returns: A representation of game data.
    func encode(gameData: GameData) -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(gameData)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
    
    /// Decodes a data representation of match data from another player.
    ///
    /// - Parameter matchData: A data representation of the game data.
    /// - Returns: A game data object.
    func decode(matchData: Data) -> GameData? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
}
