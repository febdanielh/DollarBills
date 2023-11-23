//
//  SearchingView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 15/11/23.
//

import SwiftUI
import CoreLocation

struct SearchingView: View {
    
    @EnvironmentObject var vm: ViewModel
    @Binding var isRouteSelected: Bool
    @Binding var routeSearching: String
    private let routes = CustomAnnotationAndRoute.customAnnotation
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                ForEach (routes) { route in
                    
                    if (
                        route.annotationModel.routeName.contains(routeSearching) ||
                        route.title!.contains(routeSearching) ||
                        route.location!.contains(routeSearching)
                    ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.white)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .frame(width: 354, height: 222)
                            
                            VStack (alignment: .leading) {
                                // One Image
                                Image("dummyROTW")
                                    .resizable()
                                    .frame(width: 354, height: 155)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.bottom, 4)
                                
                                VStack (alignment: .leading, spacing: 8) {
                                    Text(route.annotationModel.routeName)
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                    
                                    HStack (spacing: 6){
                                        Image("marker pin black")
                                        Text(route.location!)
                                            .font(.system(size: 14))
                                            .foregroundStyle(Color.TextDimGray)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.leading)
                                
                                Spacer()
                                
                            }.frame(height: 222)
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            vm.selectedAnnotation = route.annotationModel
                            vm.currentDisplayScreen = .viewROTWMap
                            isRouteSelected = true
                        }
                    }
                    
                    
                    
                }
                
                
                
            }
            
        }
        .scrollIndicators(.hidden)
        
    }

}
