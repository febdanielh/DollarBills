/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view that displays the game play interface.
*/

import SwiftUI
import GameKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var game: RealTimeGame
    @State private var showMessages = false
    @State private var isChatting = false
    
    var body: some View {
        VStack {
            // Display the game title.
            Text("Duel")
                .font(.title)
            
            let minute = Int(game.timeRemaining) / 60
            let second = Int(game.timeRemaining) % 60
            
            Text("\(minute):\(second)")
            
            Form {
                Section("Game Data") {
                    // Display the local player's avatar, name, and score.
                    HStack {
                        HStack {
                            game.myAvatar
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .clipShape(Circle())
                            
                            Text(game.myName + " (me)")
                                .lineLimit(2)
                        }
                        Spacer()
                        
                        Text("\(game.myScore)")
                            .lineLimit(2)
                    }
                    
                    // Display the opponent's avatar, name, and score.
                    HStack {
                        HStack {
                            game.opponentAvatar
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                                .clipShape(Circle())
                            
                            Text(game.opponentName)
                                .lineLimit(2)
                        }
                        Spacer()
                        
                        Text("\(game.opponentScore)")
                            .lineLimit(2)
                    }
                }
                .listItemTint(.blue)
                
                Section("Game Controls") {
                    Button("Take Action") {
                        game.takeAction()
                    }
                    
                    ForEach(game.myItems) { item in
                        Button {
                            game.takeActions(item: item.namaItem)
                        } label: {
                            Text("Execute \(item.namaItem)")
                        }

                    }
                }
                Section("Rules") {
                    Text("Get as far as possible in the specified time span! Use items to affect your and you opponent's run!")
                }
            }
        }
        .alert("Game Over", isPresented: $game.youWon, actions: {
            Button("OK", role: .cancel) {
                //  Save the score when the local player wins.
//                game.saveScore()
                game.resetMatch()
            }
        }, message: {
            Text("You win.")
        })
        .alert("Game Over", isPresented: $game.opponentWon, actions: {
            Button("OK", role: .cancel) {
                game.resetMatch()
            }
        }, message: {
            Text("You lose.")
        })
    }
}

struct GameViewPreviews: PreviewProvider {
    static var previews: some View {
        GameView(game: RealTimeGame())
    }
}
