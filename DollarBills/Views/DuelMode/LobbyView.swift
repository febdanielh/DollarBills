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
            ShareLink()
                .padding(.top, -150)
            
            ZStack {
                DuelAnimation()
                    .offset(x: 0, y:65)
                Image("duel")
                    .padding(.top, 150)
                Text("Guest123")
                    .offset(x: -110, y: 68)
                
                
                if isJoined {
                    Text("Guest123")
                        .offset(x: 110, y: 68)
                } else if !isJoined{
                    LoadingAnimation()
                        .offset(x: 110, y:68)
                }
            }
            
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
            }
            .padding(.top, 150)
        }
    }
}

#Preview {
    LobbyView()
}
