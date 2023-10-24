//
//  NearestRouteCard.swift
//  DollarBills
//
//  Created by Febrian Daniel on 19/10/23.
//

import SwiftUI

struct NearestRouteCard: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var tag: Int
    
    var body: some View {
        HStack {
            Text("Nearest to You")
                .foregroundStyle(.black)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: NearestToYouDetailView(tag: $tag)) {
                Text("See All >")
                    .font(.callout)
                    .foregroundStyle(Color.YellowDark4)
            }
        }
        .frame(width: 361)
        
        ScrollView(.horizontal) {
            // All Image
            HStack {
                ForEach(RouteData.routeData, id: \.self) { route in
                    VStack {
                        ZStack {
                            VStack (alignment: .leading) {
                                // One Image
                                ZStack{
                                    Image(route.routeImage)
                                        .resizable()
                                        .frame(width: 180, height: 155)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    // New!
                                    VStack {
                                        Image("New!")
                                            .frame(width: 180, height: 21, alignment: .leading)
                                        Spacer()
                                    }.frame(height:155)
                                }
                                
                                VStack (alignment: .leading) {
                                    
                                    HStack {
                                        Image("marker pin black")
                                        Text("\(route.routeName) (\(route.routeNameDetail))")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .frame(width: 140, height: 25, alignment: .leading)
                                    }
                                    
                                    HStack {
                                        Text("50m away")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .padding(.leading)
                                            .foregroundColor(Color.TextDimGray)
                                    }
                                    
                                    // Location Tag
                                    VStack {
                                        Text("4+ Routes")
                                            .font(.system(size: 13))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.black)
                                            .frame(width: 90, height: 20, alignment: .center)
                                            .background(
                                                Color.YellowNormal)
                                            .cornerRadius(9.8)
                                            .overlay (
                                                RoundedRectangle(cornerRadius: 9.8)
                                                    .stroke(Color.YellowNormal, lineWidth: 0)
                                            )
                                    }
                                    .padding(.bottom)
                                }
                                .padding(.leading)
                            }
                            .onTapGesture {
                                vm.currentDisplayScreen = .viewMap
                                tag = route.tag
                            }
                        }
                    }
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
    NearestRouteCard(tag: .constant(0))
}
