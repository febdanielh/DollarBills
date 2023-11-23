/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The home page of the real-time game.
*/

import SwiftUI
import GameKit

struct ContentView2: View {
    @EnvironmentObject private var game: RealTimeGame
    @State private var showFriends = false
    @State private var timeChosen : TimeInterval = 30
    
    var body: some View {
        VStack {
            
            // Display the game title.
            Text("Duel")
                .font(.title)
                .padding()
            Form {
                Section("Start Game") {
                    Button("Choose Player") {
                        if game.automatch {
                            // Turn automatch off.
                            GKMatchmaker.shared().cancel()
                            game.automatch = false
                        }
//                        game.choosePlayer(time: timeChosen)
                    }
                }
            }
            .disabled(!game.matchAvailable)
        }
        // Authenticate the local player when the game first launches.
        .onAppear {
            if !game.playingGame {
                game.authenticatePlayer()
            }
        }
            
        // Display the game interface if a match is ongoing.
        .fullScreenCover(isPresented: $game.playingGame) {
            GameView()
        }
        
        // Display the local player's friends.
        .sheet(isPresented: $showFriends, onDismiss: {
            showFriends = false
        }) {
            FriendsView(game: game)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
