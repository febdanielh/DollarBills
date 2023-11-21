//
//  Player.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct Player: View {
    
    @Binding var p1Win: Bool
    @Binding var p2Win: Bool
    
    var body: some View {
        
        if p1Win {
            HStack (alignment: .center) {
                ZStack {
                    Circle()
                        .frame(height: 62)
                        .foregroundColor(.blue)
                    Text("Elvis")
                        .fontWeight(.semibold)
                    Image("crown")
                        .offset(x: -17, y: -36)
                }.padding(.trailing)
                ZStack{
                    Circle()
                        .frame(height: 40)
                        .foregroundColor(.red)
                    Text("You")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                }.padding(.leading)
            }
        } else if p2Win {
            HStack (alignment: .center) {
                ZStack{
                    Circle()
                        .frame(height: 40)
                        .foregroundColor(.blue)
                    Text("Elvis")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                }.padding(.trailing)
                
                ZStack {
                    Circle()
                        .frame(height: 62)
                        .foregroundColor(.red)
                    Text("You")
                        .fontWeight(.semibold)
                    Image("crown")
                        .offset(x: -17, y: -36)
                }.padding(.leading)
            }
        }
    }
}

#Preview {
    Player(p1Win: .constant(false), p2Win: .constant(true))
}
