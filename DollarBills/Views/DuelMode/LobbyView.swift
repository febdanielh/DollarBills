//
//  LobbyView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct LobbyView: View {
    
    @State var isOwner : Bool = true
    
    @State var today : Date
    
    @State private var isJoined = true
    
    @State private var isLinkActive = true
    
    @State var timeInterval : TimeInterval
    
    @EnvironmentObject var vm : ViewModel
    
    @State var roomID: String = ""
    
    @State var roomOwnerName: String = ""
    
    var body: some View {
        VStack {
            
            Text("Duel Mode")
                .font(.headline)
                .padding()
            
            Divider()
            
            ScrollView {
                
                VStack (spacing: 50) {
                    
                    ShareLink(createdDate: today, roomID: roomID, isOwner: isOwner)
                        .frame(height: 100)
                    
                    Spacer()
                    
                    ZStack {
                        
                        DuelAnimation()
                        
                        LobbyPlayerName()
                        
                        Text(roomOwnerName)
                            .font(.system(size: 14)).bold()
                            .offset(x: -110)
                        
                        if isJoined {
                            Text("Guest123")
                                .font(.system(size: 14)).bold()
                                .offset(x: 110)
                        } else if !isJoined{
                            LoadingAnimation()
                                .offset(x: 110)
                        }
                        
                    }.frame(height: 240)
                    
                    Spacer()
                    
                    VStack{
                        if isJoined {
                            NavigationLink {
                                ChooseItemView()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 326, height: 60)
                                        .foregroundColor(Color.black)
                                    Text("Start Duel")
                                        .foregroundColor(Color.white)
                                        .font(.title3)
                                }
                            }
                        }
                        else if !isJoined {
                            Text("waiting for the host to start the duel")
                        }
                    }.padding(.top)
                }
                
            }
            
        }
        .onAppear(perform: {
            Task {
                roomID = try await vm.createDuelRoom(duration: timeInterval)
                roomOwnerName = try await vm.fetchUserName()
            }
        })
    }
    
}

#Preview {
    LobbyView(today: Date(), timeInterval: 600.0)
        .environmentObject(ViewModel())
}
