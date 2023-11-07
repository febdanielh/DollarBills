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
    
    let routes: [Routes]
    @Binding var selectedRoute: Routes
    
    var body: some View {
        HStack {
            Text("Nearest to You")
                .foregroundStyle(.black)
                .font(.title2).fontWeight(.semibold)
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
                ForEach(routes.sorted { route1, route2 in
                    let distance1 = vm.getUserDistance(latitude: route1.latitude, longitude: route1.longitude)
                    let distance2 = vm.getUserDistance(latitude: route2.latitude, longitude: route2.longitude)
                    return distance1 < distance2
                }, id: \.self) { route in
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
                                    
                                    // Spacer()
                                    HStack {
                                        Text("\(String(format: "%.1f km", vm.getUserDistance(latitude: route.latitude, longitude: route.longitude))) away")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .padding(.leading)
                                            .foregroundColor(Color.TextDimGray)
                                    }
                                    
                                    // Location Tag
                                    VStack {
                                        Text("\(route.routeCount) Routes")
                                            .font(.system(size: 13))
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color.black)
                                            .frame(width: 90, height: 20, alignment: .center)
                                            .background(
                                                Color.YellowNormal2)
                                            .cornerRadius(9.8)
                                            .overlay (
                                                RoundedRectangle(cornerRadius: 9.8)
                                                    .stroke(Color.YellowLight3, lineWidth: 0)
                                            )
                                    }
                                    .padding(.bottom)
                                }
                                .padding(.leading)
                            }
                            .onTapGesture {
                                vm.currentDisplayScreen = .viewMap
                                selectedRoute = route
                                tag = route.tag
                            }
                        }
                    }
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
                    .frame(height: 262)
                }
            }
            .padding([.bottom, .leading,.trailing])
        }
    }
}

#Preview {
    NearestRouteCard(
        tag: .constant(0),
        routes: RouteData.routeData,
        selectedRoute: .constant(Routes(tag: 0, routeName: "", routeNameDetail: "", routeImage: "", routeCount: 0, latitude: 0.0, longitude: 0.0)))
}

struct AllowLocationRect: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 354, height: 262)
                .foregroundColor(Color.YellowLight2)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color.YellowLight3, style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                )
            
            VStack(spacing: 8){
                Text("Allow Location")
                    .font(.title3).fontWeight(.semibold)
                    .padding(.vertical)
                
                Text("We will use your location data to give you route recommendation nearest to you")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.48))
                    .frame(width: 300)
                    .padding(.bottom)
                
                Button(action: {
                    vm.locationAuthorizationCheck()
                    print("allowed")
                }, label: {
                    Text("Allow")
                })
                .buttonStyle(ActiveBlackSheetButton())
                .padding()
            }
        }.padding()
    }
}
