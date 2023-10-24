//
//  QokkaPickCard.swift
//  DollarBills
//
//  Created by Febrian Daniel on 20/10/23.
//

import SwiftUI

struct QokkaPickCard: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var tag: Int
    
    var body: some View {
        HStack {
            Text("Qokka's Pick")
                .foregroundStyle(.black)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                
            }, label: {
                Text("See All >")
                    .font(.callout)
                    .foregroundStyle(Color.YellowDark4)
            })
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
                                ZStack {
                                    Image(route.routeImage)
                                        .resizable()
                                        .frame(width: 180, height: 155)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    // New!
                                    VStack {
                                        Image("New!")
                                            .frame(width: 180, height: 21, alignment: .leading)
                                        Spacer()
                                    }
                                    .frame(height: 155)
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
                                            .font(.caption)
                                            .padding(.leading)
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
                                                    .stroke(Color.YellowLight3, lineWidth: 0)
                                            )
                                    }
                                    .frame(width: 160, alignment: .leading)
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
    QokkaPickCard(tag: .constant(0))
}
