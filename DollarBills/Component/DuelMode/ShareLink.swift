//
//  ShareLink.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct ShareLink: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.orange)
            VStack(alignment: .leading) {
                Text("Monday, 16 October 2023")
                    .font(.footnote)
                Spacer()
                HStack {
                    Text("Room Code: 1234")
                        .font(.title3)
                    Button(action: {
                        // Create a sharing activity
                        let textToShare = "Room Code: 1234"
                        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
                        
                        // Present the share sheet
                        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                    }) {
                        Image(systemName: "square.and.arrow.up.fill")
                    }
                }
                .fontWeight(.bold)
                Text("Share this room code with a friend and ask them to join!")
            }
            .foregroundColor(Color.white)
            .padding(.horizontal, 30)
            .padding(.vertical)
        }
        .frame(width: 413, height: 137)
    }
}

#Preview {
    ShareLink()
}
