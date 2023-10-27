//
//  RoutesOfTheWeek.swift
//  DollarBills
//
//  Created by Febrian Daniel on 23/10/23.
//

import SwiftUI

struct RoutesOfTheWeek: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var isRouteSelected: Bool
    
    let routes: CustomAnnotation
    
    var body: some View {
        // Routes of The Week
        //        ScrollView(.horizontal) {
        // All Image
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(width: 334, height: 222)
            
            VStack (alignment: .leading) {
                // One Image
                Image(routes.annotationModel.routeName)
                    .resizable()
                    .frame(width: 334, height: 155)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 4)
                
                VStack (alignment: .leading, spacing: 8) {
                    Text(routes.annotationModel.routeName)
                        .foregroundStyle(Color.black)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    
                    HStack (spacing: 6){
                        Image("marker pin black")
                        Text(routes.location!)
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
            vm.selectedAnnotation = routes.annotationModel
            vm.currentDisplayScreen = .viewMap
            isRouteSelected = true
        }
        //        }
    }
}

#Preview {
    RoutesOfTheWeek(isRouteSelected: .constant(false), routes: CustomAnnotationAndRoute.customAnnotation[0])
}
