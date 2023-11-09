//
//  LobbyView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct LobbyView: View {
    
    @State private var isJoined = true
    @State private var isLinkActive = true
    var body: some View {
        VStack{
            Text("Duel Mode")
                .font(.headline)
                .padding()
            Divider()
            ScrollView {
                VStack (spacing: 50){
                    ShareLink()
                    
                    Spacer()
                    
                    ZStack {
                        DuelAnimation()
                        LobbyPlayerName()
                        Text("Guest123")
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
    }
}

#Preview {
    LobbyView()
}
