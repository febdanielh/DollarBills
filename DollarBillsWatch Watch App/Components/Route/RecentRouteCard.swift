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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 175, height: 44)
                .foregroundStyle(Color("Yellow: Light 2.3"))
            HStack {
                Text(routes.routeName)
                    .font(.body)
                    .foregroundStyle(Color.black)
                    .padding(.horizontal, 15)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .padding(.horizontal, 15)
            }
        }
    }
}

#Preview {
    RecentRouteCard(routes: Routes(tag: 2, routeName: "Nava Park", routeNameDetail: "BSD, Tangerang", routeImage: "naturale", routeCount: 1, latitude: -6.292648, longitude: 106.652119))
}
