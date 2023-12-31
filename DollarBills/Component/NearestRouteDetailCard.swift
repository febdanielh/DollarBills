//
//  NearestRouteDetailCard.swift
//  DollarBills
//
//  Created by Febrian Daniel on 21/10/23.
//

import SwiftUI

struct NearestRouteDetailCard: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var tag: Int
    var body: some View {
        ScrollView(.vertical) {
            // All Image
            VStack {
                ForEach(RouteData.routeData, id: \.self) { route in
                    VStack {
                        if route.routeCount > 0 {
                            ZStack {
                                HStack(spacing: 10) {
                                    // One Image
                                    Image(route.routeImage)
                                        .resizable()
                                        .frame(width: 121, height: 107)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding(8)
                                    
                                    VStack (alignment: .leading, spacing: 8) {
                                        Text("\(route.routeName) (\(route.routeNameDetail))")
                                            .font(.callout).fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
//                                            .frame(width: 180, alignment: .leading)
                                        
                                        Text("\(String(format: "%.1f km", vm.getUserDistance(latitude: route.latitude, longitude: route.longitude))) away")
                                            .font(.footnote).fontWeight(.semibold)
                                            .foregroundColor(Color.TextDimGray)
                                        
                                        Spacer()
                                        
                                        // Location Tag
                                        Text("\(route.routeCount) Route(s)")
                                            .font(.system(size: 14)).fontWeight(.semibold)
                                            .foregroundColor(.black)
                                            .frame(width: 74, alignment: .center)
                                            .padding(.vertical, 3.6)
                                            .padding(.horizontal, 9.8)
                                            .background(
                                                Color.YellowNormal)
                                            .cornerRadius(9.0)
                                    }
                                    .padding(.vertical, 5)
                                    .frame(width: 202, height: 107, alignment: .leading)
                                }
                                .onTapGesture {
                                    vm.currentDisplayScreen = .viewMap
                                    tag = route.tag
                                }
                            }
                        }
                    }
                    .frame(width: 357, alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 4)
                }
            }
            .padding([.bottom, .horizontal])
        }
        .padding(.bottom)
        .cornerRadius(8)
    }
}

#Preview {
    NearestRouteDetailCard(tag: .constant(0))
        .environmentObject(ViewModel())
}
