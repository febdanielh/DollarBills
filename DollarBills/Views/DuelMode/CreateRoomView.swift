//
//  CreateRoomView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

let timeIntervals = [
    600.0,
    1200.0,
    1800.0
]

struct CreateRoomView: View {
    
    @State var timeInterval : TimeInterval = timeIntervals[0]
    
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        VStack {
            Text("Duel Mode")
                .font(.headline).bold()
                .padding()
           
            
            Divider()
            Text(Date.now.formatted(date: .complete, time: .omitted))
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 160, height: 36)
                    .foregroundColor(Color.yellow)
                Text("Choose Duration")
            }
            .padding()
            
            
            TimePickerView(selectedTime: $timeInterval)
            
            NavigationLink {
                LobbyView(timeInterval: timeInterval)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 326, height: 60)
                        .foregroundStyle(Color.black)
                    Text("Create Room")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CreateRoomView()
}
