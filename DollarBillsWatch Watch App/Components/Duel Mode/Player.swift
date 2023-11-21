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
                        .size(width: 62, height: 62)
                        .foregroundColor(.blue)
                    Text("E")
                        .fontWeight(.semibold)
                        .offset(x: -4, y: -5)
                    Image("crown")
                        .offset(x: -20, y: -35)
                }
                
                ZStack{
                    Circle()
                        .size(width: 33, height: 33)
                        .foregroundColor(.red)
                    Text("You")
                        .fontWeight(.semibold)
                        .offset(x:-18, y:-17)
                }
                .offset(y: 12)
                
            }
            .padding(.leading, 25)
        } else if p2Win {
            HStack (alignment: .center) {
                
                ZStack{
                    Circle()
                        .size(width: 33, height: 33)
                        .foregroundColor(.blue)
                    Text("E")
                        .fontWeight(.semibold)
                        .offset(x:-18, y:-17)
                }
                .offset(x: 12, y: 12)
                
                
                ZStack {
                    Circle()
                        .size(width: 62, height: 62)
                        .foregroundColor(.red)
                    Text("You")
                        .fontWeight(.semibold)
                        .offset(x: -4, y: -5)
                    Image("crown")
                        .offset(x: -20, y: -35)
                }
                .offset(x: -10)
                
            }
            .padding(.leading, 25)
        }
        
    }
}

//#Preview {
//    Player()
//}
