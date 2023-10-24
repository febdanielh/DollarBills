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
                        ZStack {
                            HStack(spacing: 16) {
                                // One Image
                                Image(route.routeImage)
                                    .resizable()
                                    .frame(width: 121, height: 107)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(8)
                                
                                VStack (alignment: .leading, spacing: 8) {
                                    Text("\(route.routeName) (\(route.routeNameDetail))")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                    Text("50m away")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.TextDimGray)
                                    Spacer().frame(height: 2)
                                    // Location Tag
                                    Text("4+ Routes")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .frame(width: 74, alignment: .center)
                                        .padding(.vertical, 3.6)
                                        .padding(.horizontal, 9.8)
                                        .background(
                                            Color.YellowNormal)
                                        .cornerRadius(9.0)
                                }
                                .padding(.vertical, 10)
                                .frame(width: 202, alignment: .leading)
                            }
                            .onTapGesture {
                                vm.currentDisplayScreen = .viewMap
                                tag = route.tag
                            }
                        }
                    }
                    .frame(width: 357, alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 4)
                }
            }
            .padding([.bottom, .leading,.trailing])
        }
        .padding(.bottom)
        .cornerRadius(8)
    }
}

#Preview {
    NearestRouteDetailCard(tag: .constant(0))
}
