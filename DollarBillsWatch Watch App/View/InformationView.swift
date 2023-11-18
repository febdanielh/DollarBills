//
//  InformationView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var wm: WorkoutManager
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color(red: 1, green: 0.98, blue: 0.85))
            VStack (alignment: .center){
                Text("Access Furthr on your iPhone to view summary")
                    .font(.caption)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.bottom, -10)
                Image("frame0")
                    .resizable()
                    .frame(maxWidth: 70, maxHeight: 70)
            }
        }
        //        .frame(width: 180, height: 150)
        .onTapGesture {
            wm.currentDisplayScreen = .viewHome
        }
    }
}

#Preview {
    InformationView()
}
