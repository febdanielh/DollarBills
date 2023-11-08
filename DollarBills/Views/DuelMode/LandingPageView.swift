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
            VStack {
                ZStack {
                    Image("frame1")
                        .resizable()
                        .scaleEffect(x: -1, y: 1)
                        .frame(width: 350, height: 350)
                        .offset(x: 130, y: -40)
                    VStack (alignment: .leading){
                        
                        Text("Hey Buddies!")
                            .font(.body)
                        Text("Invite your friend by creating new room or join room to start the duel")
                            .frame(width: 162)
                            .font(.headline)
                        
                    }.padding(.leading, -100)
                }
                //
                //                            Text("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                //                                .font(.title)
                //                                .padding()
                //
                
                if roomManager.isJoiningRoom {
                    Text("Joining Room: \(roomManager.roomToJoin?.code ?? "N/A")")
                        .font(.title)
                        .padding()
                } else {
                    Text("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                        .font(.title)
                        .padding()
                }
                
                NavigationLink {
                    CreateRoomView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 326, height: 60)
                            .foregroundColor(Color.black)
                        Text("Create Room")
                            .foregroundColor(Color.white)
                            .font(.title3)
                    }
                }
                .onSubmit {
                    roomManager.createRoom()
                    print("Room Code: \(roomManager.rooms.last?.code ?? "N/A")")
                }
                
                
                
                
                Button(action: {
                    isShowingPopup.toggle()
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 326, height: 60)
                            .foregroundStyle(Color.black)
                        Text("Join Room")
                            .foregroundStyle(Color.white)
                            .font(.title3)
                    }
                })
                .padding(.top, 25)
                .sheet(isPresented: $isShowingPopup) {
                    JoinRoomView(isPopoverPresented: $isShowingPopup, enteredCode: $enteredCode)
                }
            }
        }
    }
}

#Preview {
    LandingPageView(roomManager: RoomManager())
}

