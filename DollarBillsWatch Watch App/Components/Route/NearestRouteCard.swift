//
//  RouteCard.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 15/11/23.
//

import SwiftUI

struct NearestRouteCard: View {
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
    NearestRouteCard(routes: Routes(tag: 3, routeName: "Green Office Park", routeNameDetail: "BSD, Tangerang", routeImage: "green office park", routeCount: 3, latitude: -6.301616, longitude: 106.651096))
}
