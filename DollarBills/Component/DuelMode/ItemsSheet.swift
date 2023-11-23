//
//  ItemsSheet.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ItemsSheet: View {
    
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var game: RealTimeGame
    @EnvironmentObject var ptw: PhoneToWatch
    @Binding var selectedItems: [Items]
    @Binding var timeInterval: TimeInterval
    @State var isItemFull: Bool = false
    
    var body: some View {
        ZStack() {
            UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 16)
                .foregroundStyle(.white)
                .frame(height: 330)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Items")
                    .font(.headline)
                    .padding(.bottom)
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(ItemsData.item) { item in
                            ItemDescriptionContainer(item: item)
                                .onTapGesture {
                                    if selectedItems.count < 3 {
                                        selectedItems.append(item)
                                    }
                                }
                        }
                    }
                }
                
                Button(action: {
//                    Task {
//                        do {
//                            try await vm.createDuelRoom(duration: timeInterval)
//                        } catch {
//                            print(error)
//                        }
//                    }
                    game.choosePlayer(time: timeInterval, items: selectedItems)
                }, label: {
                    Text("Create Room")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                })
                .buttonStyle(ActiveBlackButtonDuel())
                .disabled(!game.matchAvailable)
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ItemsSheet(selectedItems: .constant([]), timeInterval: .constant(1200))
}

//NavigationLink {
//    DuelView()
//} label: {
//    ZStack{
//        RoundedRectangle(cornerRadius: 25)
//            .frame(width: 326, height: 45)
//            .foregroundColor(Color.black)
//        Text("Start Duel")
//            .foregroundColor(Color.white)
//            .font(.title3)
//    }
//}
