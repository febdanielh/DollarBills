/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main class that implements the logic for a simple real-time game.
*/

import Foundation
import GameKit
import SwiftUI

/// - Tag:RealTimeGame
@MainActor
class RealTimeGame: NSObject, GKGameCenterControllerDelegate, ObservableObject {
    
    // The local player's friends, if they grant access.
    @Published var friends: [Friend] = []
    
    // The game interface state.
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    
    // Outcomes of the game for notifing players.
    @Published var youForfeit = false
    @Published var opponentForfeit = false
    @Published var youWon = false
    @Published var opponentWon = false
    
    // The match information.
    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    @Published var opponent: GKPlayer? = nil
    @Published var myAction: TimeInterval = 0
    @Published var myScore: Int = 0
    @Published var timeRemaining: TimeInterval = 0
    @Published var opponentScore: Int = 0
    @Published var globalTimer : Timer?
    
    // The voice chat properties.
    @Published var voiceChat: GKVoiceChat? = nil
    @Published var opponentSpeaking = false
    
    /// The name of the match.
    var matchName: String {
        "\(opponentName) Match"
    }
    
    /// The local player's name.
    var myName: String {
        GKLocalPlayer.local.displayName
    }
    
    /// The opponent's name.
    var opponentName: String {
        opponent?.displayName ?? "Invitation Pending"
    }
    
    /// The root view controller of the window.
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }

    /// Authenticates the local player, initiates a multiplayer game, and adds the access point.
    /// - Tag:authenticatePlayer
    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }
            
            // A value of nil for viewController indicates successful authentication, and you can access
            // local player properties.
            
            // Load the local player's avatar.
            GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small) { image, error in
                if let image {
                    self.myAvatar = Image(uiImage: image)
                }
                if let error {
                    // Handle an error if it occurs.
                    print("Error: \(error.localizedDescription).")
                }
            }

            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
            
            // Add an access point to the interface.
            GKAccessPoint.shared.location = .topLeading
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = false
            
            // Enable the Start Game button.
            self.matchAvailable = true
        }
    }
    
    /// Starts the matchmaking process where GameKit finds a player for the match.
    /// - Tag:findPlayer
    func findPlayer(time: TimeInterval) async {
        timeRemaining = time
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        let match: GKMatch
        
        // If you use matchmaking rules, set the GKMatchRequest.queueName property here. If the rules use
        // game-specific properties, set the local player's GKMatchRequest.properties too.
        
        // Start automatch.
        do {
            match = try await GKMatchmaker.shared().findMatch(for: request)
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }

        // Start the game, although the automatch player hasn't connected yet.
        if !playingGame {
            startMyMatchWith(match: match, time: time)
        }

        // Stop automatch.
        GKMatchmaker.shared().finishMatchmaking(for: match)
        automatch = false
    }
    
    /// Presents the matchmaker interface where the local player selects and sends an invitation to another player.
    /// - Tag:choosePlayer
    func choosePlayer() {
        // Create a match request.
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        // If you use matchmaking rules, set the GKMatchRequest.queueName property here. If the rules use
        // game-specific properties, set the local player's GKMatchRequest.properties too.
        
        // Present the interface where the player selects opponents and starts the game.
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
    }
    
    // Starting and stopping the game.
    
    /// Starts a match.
    /// - Parameter match: The object that represents the real-time match.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch, time: TimeInterval) {
        GKAccessPoint.shared.isActive = false
        playingGame = true
        myMatch = match
        myMatch?.delegate = self
        globalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.decreaseTimer()
        }
        
        // For automatch, check whether the opponent connected to the match before loading the avatar.
        if myMatch?.expectedPlayerCount == 0 {
            opponent = myMatch?.players[0]
        }
    }
    
    func decreaseTimer() {
        timeRemaining = timeRemaining - 0.5
        if (timeRemaining <= 0) {
            endMatch()
        }
    }
    
    /// Takes the player's turn.
    /// - Tag:takeAction
    func takeAction() {
        // Take your turn by incrementing the counter.
        timeRemaining += 1
        
        // Otherwise, send the game data to the other player.
        do {
            let data = encode(timeRemaining: timeRemaining)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// Quits a match and saves the game data.
    /// - Tag:endMatch
    func endMatch() {
        let myOutcome = myScore >= opponentScore ? "won" : "lost"
        let opponentOutcome = opponentScore > myScore ? "won" : "lost"
        
        // Notify the opponent that they won or lost, depending on the score.
        do {
            let data = encode(outcome: opponentOutcome)
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
        
        // Notify the local player that they won or lost.
        if myOutcome == "won" {
            youWon = true
        } else {
            opponentWon = true
        }
    }
    
    /// Saves the local player's score.
    /// - Tag:saveScore
//    func saveScore() {
//        GKLeaderboard.submitScore(myScore, context: 0, player: GKLocalPlayer.local,
//            leaderboardIDs: ["123"]) { error in
//            if let error {
//                print("Error: \(error.localizedDescription).")
//            }
//        }
//    }
    
    /// Resets a match after players reach an outcome or cancel the game.
    func resetMatch() {
        // Reset the game data.
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        opponent = nil
        opponentAvatar = Image(systemName: "person.crop.circle")
        GKAccessPoint.shared.isActive = true
        youWon = false
        opponentWon = false
        // Reset the score.
        timeRemaining = 0
        myScore = 0
        opponentScore = 0
    }
    
}
