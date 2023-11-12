//
//  ShareLink.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ShareLink: View {
    
    @State var createdDate : Date
    
    @EnvironmentObject var vm : ViewModel
    
    let isOwner: Bool
    
    var body: some View {
        
        VStack{
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color.orange)
                
                VStack(alignment: .leading) {
                
                    Text(String(createdDate.formatted(date: .complete, time: .omitted)))
                        .font(.footnote)
                    
                    if isOwner {
                        
                        Spacer()
                        
                        HStack {
                            
                            Button(action: {
                                // Create a sharing activity
                                let textToShare = "Are you up for a duel?\nCome face me on Further!\nWith my room code: \(vm.currentRoomID)"
                                let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
                                
                                // Present the share sheet
                                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                            }) {
                                Text("Room Code \(vm.currentRoomID)")
                                    .font(.title3)
                                Image(systemName: "square.and.arrow.up.fill")
                            }
                        }
                        .fontWeight(.bold)
                        Text("Share this room code with a friend and ask them to join!")
                        
                    }
                    
                }
                .foregroundColor(Color.white)
                .padding(.horizontal, 30)
                .padding(.vertical)
            }
            .frame(minWidth: 413, maxHeight: 13)
        }
    }
}

//#Preview {
//    ShareLink(createdDate: Date(), roomID: "Test", isOwner: true)
//}
