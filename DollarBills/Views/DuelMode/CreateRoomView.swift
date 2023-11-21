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
    
    @EnvironmentObject var vm : ViewModel
    @EnvironmentObject var game: RealTimeGame
    @State var roomID = ""
    @State var today = Date()
    @State var timeInterval : TimeInterval = timeIntervals[0]
    
    var body: some View {
        VStack {
            Divider()
                .padding(.bottom)
            
            Spacer()
            Text(Date.now.formatted(date: .complete, time: .omitted))
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 160, height: 36)
                    .foregroundColor(Color.yellow)
                Text("Choose Duration")
            }
            .padding()

            TimePickerView(selectedTime: $timeInterval)
            
            NavigationLink(destination: ChooseItemView(timeInterval: $timeInterval)) {
                Text("Create Room")
                    .font(.title3)
            }
            .buttonStyle(ActiveBlackButtonDuel())
            .padding()
            Spacer()
        }
        .fullScreenCover(isPresented: $game.playingGame) {
            GameView(game: game)
        }
        .navigationBarTitle(Text("Duel Mode"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CreateRoomView()
}

//Button(action: {
//    Task {
//        do {
//            try await vm.createDuelRoom(duration: timeInterval)
//        } catch {
//            print(error)
//        }
//    }
//    game.choosePlayer(time: timeInterval)
//}, label: {
//    Text("Create Room")
//        .foregroundStyle(Color.white)
//        .font(.title3)
//})
//.buttonStyle(ActiveBlackButtonDuel())
//.padding()
//.disabled(!game.matchAvailable)

