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
    @Binding var selectedRoute: AnnotationModel?
    
    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEach(CustomAnnotationAndRoute.customAnnotation, id: \.self) { route in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 357, height: 123)
                            .background(Color.white)
                        HStack(){
                            Image("dummy-image")
                                .padding()
                            Spacer().frame(width: 10)
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.YellowDark)
                                        .frame(width: 72, height: 21)
                                        .background(Color.YellowLightactive)
                                    HStack(spacing: 6){
                                        Image("marker-pin-01")
                                        Text("50 m")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.YellowDark)
                                            .bold()
                                    }
                                }
                                Text(route.annotationModel.routeName)
                                    .font(.system(size: 17))
                                    .bold()
                                Text("Collect 5km in \n\(route.annotationModel.routeName)")
                                    .font(.system(size: 13))
                                    .bold()
                                    .foregroundStyle(Color.TextDimGray)
                                    .opacity(0.7)
                            }
                            Spacer()
                        }.frame(width: 361)
                    }
                    .onTapGesture {
                        vm.cachedDirections.removeAll()
                        vm.routes.removeAll()
                        selectedRoute = route.annotationModel
                    }
                }
            }
        }
    }
}


#Preview {
    RouteCards(selectedRoute: .constant(CustomAnnotationAndRoute.customAnnotation[0].annotationModel))
}
