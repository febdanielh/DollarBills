//
//  RecentRouteCard.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 15/11/23.
//

import SwiftUI

struct RecentRouteCard: View {
    var routes: Routes

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 170, height: 44)
                .foregroundStyle(Color(red: 1, green: 0.95, blue: 0.7))
            HStack {
                Text(routes.routeName)
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
    RecentRouteCard(routes: Routes(tag: 3, routeName: "Green Office Park", routeNameDetail: "BSD, Tangerang", routeImage: "green office park", routeCount: 3, latitude: -6.301616, longitude: 106.651096))
}
