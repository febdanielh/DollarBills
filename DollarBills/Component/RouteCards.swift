//
//  RouteCards.swift
//  DollarBills
//
//  Created by Febrian Daniel on 17/10/23.
//

import SwiftUI
import MapKit

struct RouteCards: View {
    
    @EnvironmentObject var vm: ViewModel
    @Binding var selectedAnnotation: AnnotationModel
    @Binding var tag: Int
    @Binding var isRouteSelected: Bool
    
    @Binding var selectedRoute: Routes
    @Binding var directions: [String]
    @Binding var currentRouteIndex: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                VStack (alignment: .leading, spacing: 5) {
                    if selectedRoute == Routes(tag: 0, routeName: "", routeNameDetail: "", routeImage: "", routeCount: 0, latitude: 0.0, longitude: 0.0) {
                        Text(selectedAnnotation.routeName)
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .padding(.top)
                        
                    } else {
                        Text(selectedRoute.routeName)
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .padding(.top)
                        Text(selectedRoute.routeNameDetail)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    vm.currentDisplayScreen = .viewMain
                } label: {
                    Image("close black").padding()
                }
            }.padding(.leading)
            
            ScrollView {
                LazyVStack() {
                    if selectedRoute.routeCount > 0 {
                        ForEach(CustomAnnotationAndRoute.customAnnotation, id: \.self) { route in
                            if tag == route.tag {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .frame(width: 357, height: 123)
                                        .background(Color.white)
                                    HStack(spacing: 12){
                                        Image("dummy-image")
                                            .resizable()
                                            .frame(width: 121, height: 107)
                                            .padding(8)
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(route.annotationModel.routeName)
                                                .font(.headline)
                                            
                                            let totalDistance = vm.routes.reduce(0){$0 + $1.distance}
                                            let totalDistanceKM = totalDistance / 1000
                                            
//                                            \(String(format: "%.2f km", totalDistanceKM))
                                            
                                            Text("Collect 5km in \(route.annotationModel.routeName)")
                                                .font(.footnote).fontWeight(.medium)
                                                .frame(width: 170, height: 30, alignment: .topLeading)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(nil)
                                                .foregroundStyle(Color.TextDimGray)
                                            
//                                            Spacer()
                                            
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.YellowLight2)
                                                    .frame(width: 72, height: 21)
                                                    .background(Color.YellowLight2)
                                                HStack(spacing: 3){
                                                    Image("marker-pin-01")
                                                    
                                                    let distance = vm.getUserDistance(latitude: route.coordinate.latitude, longitude: route.coordinate.longitude)
                                                    let distanceMeter = distance*100
                                                    
                                                    Text("\(distanceMeter, specifier: "%.1f m")")
                                                        .font(.caption).fontWeight(.semibold)
                                                        .foregroundColor(Color.black)
                                                }
                                            }
                                        }
                                        .frame(width: 185, height: 83)
                                        Spacer()
                                    }.frame(width: 357)
                                }
                                .onTapGesture {
                                    vm.removeAll()
                                    directions.removeAll()
                                    
                                    selectedAnnotation = route.annotationModel
                                    isRouteSelected = true
                                    currentRouteIndex = route.index(ofAccessibilityElement: self)
                                }
                            }
                        }
                    } else {
                        VStack{
                            Spacer().frame(height: 50)
                            Text("Sorry this route doesn't have any routes yet!")
                                .padding(.vertical)
                        }
                    }
                }
            }
        }
        .presentationDetents([.fraction(0.2), .fraction(0.47)])
        .interactiveDismissDisabled(true)
        .presentationBackgroundInteraction(.enabled)
    }
}


#Preview {
    RouteCards(
        selectedAnnotation: .constant(CustomAnnotationAndRoute.customAnnotation[0].annotationModel),
        tag: .constant(0),
        isRouteSelected: .constant(true),
        selectedRoute: .constant(Routes(tag: 10, routeName: "", routeNameDetail: "", routeImage: "", routeCount: 0, latitude: 0.0, longitude: 0.0)),
        directions: .constant([]),
        currentRouteIndex: .constant(0))
}
