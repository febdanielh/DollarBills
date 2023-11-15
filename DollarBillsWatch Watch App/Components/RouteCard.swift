//
//  RouteCard.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 15/11/23.
//

import SwiftUI

struct RouteCard: View {
    @Binding var tag: Int
//    var routes: Routes
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 175, height: 50)
                .foregroundStyle(Color(red: 1, green: 0.95, blue: 0.7))
            HStack {
                Text("Mozia Loop")
                    .foregroundStyle(Color.black)
                    .padding(.leading, 15)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .padding(.trailing, 30)
            }
        }
    }
}

#Preview {
    RouteCard(tag: .constant(0))
}
