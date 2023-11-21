//
//  GameFromWatch.swift
//  DollarBillsWatch Watch App
//
//  Created by Febrian Daniel on 20/11/23.
//

import SwiftUI
import GameKit

//class GameFromWatch: NSObject, ObservableObject {
//    // The game interface state.
//    @Published var matchAvailable = false
//    @Published var playingGame = false
//    @Published var myMatch: GKMatch? = nil
//    @Published var automatch = false
//    @Published var isConnected = false
//    
//    // Outcomes of the game for notifing players.
//    @Published var youForfeit = false
//    @Published var opponentForfeit = false
//    @Published var youWon = false
//    @Published var opponentWon = false
//    
//    // The match information.
//    @Published var myAvatar = Image(systemName: "person.crop.circle")
//    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
//    @Published var opponent: GKPlayer? = nil
//    @Published var myAction: TimeInterval = 0
//    @Published var myScore: Int = 0
//    @Published var timeRemaining: TimeInterval = 0
//    @Published var opponentScore: Int = 0
//    @Published var globalTimer : Timer?
//    @Published var distance: Double = 0.0
////    @Published var myItems: [Items] = []
//    
//    /// The name of the match.
//    var matchName: String {
//        "\(opponentName) Match"
//    }
//    
//    /// The local player's name.
//    var myName: String {
//        GKLocalPlayer.local.displayName
//    }
//    
//    /// The opponent's name.
//    var opponentName: String {
//        opponent?.displayName ?? "Invitation Pending"
//    }
//    
//    // Starting and stopping the game.
//    
//    /// Starts a match.
//    /// - Parameter match: The object that represents the real-time match.
//    /// - Tag:startMyMatchWith
//    func startMyMatchWith(match: GKMatch, time: TimeInterval/*, items: [Items]*/) { //bisa jadi tambahin parameter items: [Items]
//        GKAccessPoint.shared.isActive = false
//        playingGame = true
//        myMatch = match
//        myMatch?.delegate = self
////        myItems = items
//        
//        globalTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            self.decreaseTimer()
//        }
//        
//        // For automatch, check whether the opponent connected to the match before loading the avatar.
//        if myMatch?.expectedPlayerCount == 0 {
//            opponent = myMatch?.players[0]
//        }
//    }
//    
//    func decreaseTimer() {
//        timeRemaining = timeRemaining - 1
//        if (timeRemaining <= 0) {
//            globalTimer?.invalidate()
//            endMatch()
//        }
//    }
//    
//    /// Takes the player's turn.
//    /// - Tag:takeAction
//    func takeAction() {
//        // Take your turn by incrementing the counter.
//        timeRemaining += 1
//        
//        // Otherwise, send the game data to the other player.
//        do {
//            let data = encode(timeRemaining: timeRemaining)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//    }
//    
//    func takeActionRock() {
//        //freeze distance for 10 seconds -> basically ngurangin timer selama 10 detik
//        timeRemaining -= 10
//        
//        do {
//            let data = encode(timeRemaining: timeRemaining)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//    }
//    
//    var tempTimer: Timer?
//    
//    func takeActionBluePotion() {
//        //double up distance obtained for 10 seconds
//        var tempDistance = 0.0
//        var tempDuration = 10.0
//        
//        tempTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else {
//                self?.tempTimer?.invalidate()
//                return
//            }
//            
//            // Update the time remaining
//            tempDuration -= 1.0
//            
//            //Update distance obtained
//            tempDistance += self.distance
//            
//            // Check if the power-up time has elapsed
//            if tempDuration <= 0 {
//                tempTimer?.invalidate()
//                tempDuration = 0
//            } else {
//                // Double the distance
//                self.distance += tempDistance
//                
//                // Send updated distance data
//                do {
//                    let data = self.encode(distance: self.distance)
//                    try self.myMatch?.sendData(toAllPlayers: data!, with: .unreliable)
//                } catch {
//                    print("Error: \(error.localizedDescription).")
//                }
//            }
//        }
//    }
//    
//    func takeActionRedPotion() {
//        //half the distance obtained in 10 second
//        var tempDistance = 0.0
//        var tempDuration = 10.0
//        
//        tempTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else {
//                self?.tempTimer?.invalidate()
//                return
//            }
//            
//            // Update the time remaining
//            tempDuration -= 1.0
//            
//            //Update distance obtained
//            tempDistance += self.distance
//            
//            // Check if the power-up time has elapsed
//            if tempDuration <= 0 {
//                tempTimer?.invalidate()
//                tempDuration = 0
//            } else {
//                // Double the distance
//                self.distance += tempDistance
//                
//                // Send updated distance data
//                do {
//                    let data = self.encode(distance: self.distance)
//                    try self.myMatch?.sendData(toAllPlayers: data!, with: .unreliable)
//                } catch {
//                    print("Error: \(error.localizedDescription).")
//                }
//            }
//        }
//    }
//    
//    func takeAction3Rocks() {
//        //3 Rocks can freeze opponent for 10 s and reduce the amount of distance gain within 10 s
//        var tempDistance = 0.0
//        var tempDuration = 10.0
//        
//        tempTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else {
//                self?.tempTimer?.invalidate()
//                return
//            }
//            
//            // Update the time remaining
//            tempDuration -= 1.0
//            
//            //Update distance obtained
//            tempDistance += self.distance
//            
//            // Check if the power-up time has elapsed
//            if tempDuration <= 0 {
//                tempTimer?.invalidate()
//                tempDuration = 0
//            } else {
//                // Double the distance
//                self.distance += tempDistance
//                
//                // Send updated distance data
//                do {
//                    let data = self.encode(distance: self.distance)
//                    try self.myMatch?.sendData(toAllPlayers: data!, with: .unreliable)
//                } catch {
//                    print("Error: \(error.localizedDescription).")
//                }
//            }
//        }
//    }
//    
//    func takeActionBomb() {
//        //reduce distance by 200m
//        var tempDistance = 200.0
//        
//        self.distance -= tempDistance
//        
//        do {
//            let data = encode(distance: distance)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//    }
//    
//    func takeActionWhiteFlag() {
//        //add 200 m
//        var tempDistance = 200.0
//        self.distance += tempDistance
//        
//        do {
//            let data = encode(distance: distance)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//    }
//    
//    /// Quits a match and saves the game data.
//    /// - Tag:endMatch
//    func endMatch() {
//        let myOutcome = myScore >= opponentScore ? "won" : "lost"
//        let opponentOutcome = opponentScore > myScore ? "won" : "lost"
//        
//        // Notify the opponent that they won or lost, depending on the score.
//        do {
//            let data = encode(outcome: opponentOutcome)
//            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
//        } catch {
//            print("Error: \(error.localizedDescription).")
//        }
//        
//        // Notify the local player that they won or lost.
//        if myOutcome == "won" {
//            youWon = true
//        } else {
//            opponentWon = true
//        }
//    }
//    
//    /// Resets a match after players reach an outcome or cancel the game.
//    func resetMatch() {
//        // Reset the game data.
//        playingGame = false
//        isConnected = false
//        myMatch?.disconnect()
//        myMatch?.delegate = nil
//        myMatch = nil
//        opponent = nil
//        opponentAvatar = Image(systemName: "person.crop.circle")
//        GKAccessPoint.shared.isActive = false
//        youWon = false
//        opponentWon = false
//        // Reset the score.
//        timeRemaining = 0
//        myScore = 0
//        opponentScore = 0
//    }
//}
