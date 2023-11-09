//
//  LandingPageView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject var roomManager: RoomManager
    @State private var isShowingPopup = false
    @State private var enteredCode = ""
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("Duel Mode")
                    .font(.system(size: 30)).bold()
                    .padding()
                
                Divider()
                
                ScrollView {
                    VStack {
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
                        
                        Spacer()
                        //
                        //                            Text("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                        //                                .font(.title)
                        //                                .padding()
                        //
                        VStack {
                            if roomManager.isJoiningRoom {
                                Text("Joining Room: \(roomManager.roomToJoin?.code ?? "N/A")")
                                    .font(.title3)
                                    .padding()
                            } else {
                                Text("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                                    .font(.title3)
                                    .padding()
                            }
                        }.frame(maxWidth: .infinity)
                        
                        NavigationLink {
                            CreateRoomView()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(width: 326, height: 44)
                                    .foregroundColor(Color.black)
                                Text("Create Room")
                                    .foregroundColor(Color.white)
                                    .font(.title3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .onSubmit {
                            roomManager.createRoom()
                            print("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                        }
                        
                        Button(action: {
                            isShowingPopup.toggle()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(width: 326, height: 44)
                                    .foregroundStyle(Color.black)
                                Text("Join Room")
                                    .foregroundStyle(Color.white)
                                    .font(.title3)
                            }
                        })
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        .sheet(isPresented: $isShowingPopup) {
                            JoinRoomView(isPopoverPresented: $isShowingPopup, enteredCode: $enteredCode)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LandingPageView(roomManager: RoomManager())
}

