//
//  InformationView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.yellow)
            VStack (alignment: .center){
                Text("Access Furthr on your iPhone to view summary")
                    .multilineTextAlignment(.center)
                    .padding()
                Image("frame1")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    InformationView()
}
