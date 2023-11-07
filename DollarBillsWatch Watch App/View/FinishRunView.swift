//
//  FinishRunView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct FinishRunView: View {
    var body: some View {
        VStack {
            Text("Are You Sure?")
            
            NavigationLink {
                RunViewTab()
                    .navigationBarBackButtonHidden(true)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 175, height: 50)
                        .foregroundStyle(Color.red)
                    Text("Finish Run")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .padding(.top, 8)
            
            NavigationLink {
                LandingPageView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 175, height: 50)
                        .foregroundStyle(Color.yellow)
                    Text("New Run")
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    FinishRunView()
}
