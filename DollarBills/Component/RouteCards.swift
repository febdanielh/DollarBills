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
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                VStack (alignment: .leading, spacing: 5){
                    ForEach(RouteData.routeData, id: \.self) { title in
                        if tag == title.tag {
                            Text(title.routeName)
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                                .padding(.top)
                            Text(title.routeNameDetail)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                        }
                    }
                }
                Spacer()
                Button {
                    vm.currentDisplayScreen = .viewMain
                } label: {
                    Image("close button yellow").padding()
                }
            }.padding(.leading)
            
            Divider()
            
            ScrollView {
                LazyVStack() {
                    ForEach(CustomAnnotationAndRoute.customAnnotation, id: \.self) { route in
                        if tag == route.tag {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 357, height: 123)
                                    .background(Color.white)
                                HStack(){
                                    Image("dummy-image")
                                        .padding()
                                    Spacer().frame(width: 10)
                                    VStack(alignment: .leading, spacing: 10) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.YellowDark4)
                                                .frame(width: 72, height: 21)
                                                .background(Color.YellowNormal)
                                            HStack(spacing: 6){
                                                Image("marker-pin-01")
                                                Text("50 m")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color.YellowDark3)
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
                                selectedAnnotation = route.annotationModel
                                isRouteSelected = true
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    RouteCards(selectedAnnotation: .constant(CustomAnnotationAndRoute.customAnnotation[0].annotationModel), tag: .constant(0), isRouteSelected: .constant(true))
}
