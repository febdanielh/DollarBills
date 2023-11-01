//
//  RunViewPage3.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunViewPage3: View {
    var body: some View {
        VStack (spacing: 20) {
            Text("5.12 KM")
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Image (systemName: "heart.circle")
                    .foregroundColor(Color.pink)
                    .font(.title3)
                Text("64")
                
                Spacer()
                
                Text("00:20,04")
            }
            .fontWeight(.semibold)
            
            Spacer()
            
            
            HStack {
                VStack (spacing: 5) {
                    Text("02'05\"")
                        .fontWeight(.semibold)
                    Text("Pace")
                }
                Spacer()
                VStack (spacing: 5) {
                    Text("164 kcal")
                        .fontWeight(.semibold)
                    Text("Calories")
                }
            }
  
            
        }
        .padding(.horizontal)
        .font(.title3)
    }
}

#Preview {
    RunViewPage3()
}
