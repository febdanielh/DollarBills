//
//  ChooseItemView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ChooseItemView: View {
    @EnvironmentObject var game: RealTimeGame
    @State var selectedItems: [Items] = []
    @Binding var timeInterval: TimeInterval
    var body: some View {
        VStack {
            Divider()
            ZStack {
                Color.WPBG
                    .ignoresSafeArea()
                VStack {
                    Text("Choose 3 items for duel")
                        .font(.title3)
                        .bold()
                    
                    HStack (spacing: 5) {
                        ForEach(selectedItems) { item in
                            ChosenItemContainer(imageName: item.image)
                                .onTapGesture {
                                    if let index = selectedItems.firstIndex(where: {$0.id == item.id}) {
                                        selectedItems.remove(at: index)
                                    }
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            ItemsSheet(selectedItems: $selectedItems, timeInterval: $timeInterval)
        }
        .navigationBarTitle(Text("Duel Mode"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChooseItemView(timeInterval: .constant(1200))
}
