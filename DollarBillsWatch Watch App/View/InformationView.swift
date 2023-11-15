//
//  InformationView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationLink {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
//                    .foregroundColor(Color.yellow)
                    .foregroundColor(Color(red: 1, green: 0.98, blue: 0.85))
                VStack (alignment: .center){
                    Text("Access Furthr on your iPhone to view summary")
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom, -8)
                    Image("frame0")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
            }
        }
        .frame(width: 220, height: 180)
    }
}

#Preview {
    InformationView()
}
