//
//  ResultView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 17/11/23.
//

import SwiftUI

struct ResultView: View {
    
    @State private var isWin: Bool = false
    
    var body: some View {
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 170, height: 78)
                    .foregroundColor(Color(red: 1, green: 0.98, blue: 0.85))
                if isWin{
                    VStack {
                        Text("Congratulations")
                        Text("You Win!")
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                    
                } else {
                    VStack {
                        Text("Don't give up")
                        Text("You Lose")
                            .font(.title2)
                    }
                    .foregroundColor(.black)
                }
                
            }
            
            if isWin{
                Image("winOni")
                    .resizable()
                    .padding(.bottom, -35)
                    .padding(.top, -10)
                    .offset(x:50)
                    .frame(width: 250, height: 115)
            } else {
                Image("loseOni")
                    .resizable()
                    .frame(width:200, height:140)
                    .padding(.top, -25)
                    
            }
            
        }
        .padding(.vertical, 20)
        
    }
}

#Preview {
    ResultView()
