//
//  LandingPageView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct LandingPageView: View {
    
    @ObservedObject var roomManager: RoomManager
    @EnvironmentObject var game: RealTimeGame
    @State private var isShowingPopup = false
    @State private var timeChosen : TimeInterval = 1200
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("Duel Mode")
                    .font(.system(size: 30)).bold()
                    .padding([.top, .horizontal])
                Divider()
                
                ScrollView {
                    VStack {
                        Spacer()
                        ZStack{
                            HStack {
                                Spacer()
                                Image("ButoIjo")
                            }
                            
                            HStack {
                                VStack (alignment: .leading, spacing: 15){
                                    Text("Hey Buddies!")
                                        .font(.body)
                                    Text("Invite your friend or join room to start the duel")
                                        .frame(width: 162)
                                        .font(.headline)
                                    
                                }
                                Spacer()
                            }.padding(.leading).padding(.leading)
                        }
                        .padding(.vertical)
                        
                        Spacer().frame(height: 80)
                        
                        NavigationLink {
                            CreateRoomView()
                        } label: {
                            Text("Create Room")
                                .foregroundColor(Color.white)
                                .font(.title3)
                        }.buttonStyle(ActiveBlackButtonDuel())
                    }
                }
            }
        }
    }
}

#Preview {
    LandingPageView(roomManager: RoomManager())
}

