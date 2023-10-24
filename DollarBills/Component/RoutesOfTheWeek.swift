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
    
    var body: some View {
        Text("Routes of The Week")
            .foregroundStyle(.black)
            .font(.system(size: 20)).fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .frame(width: 361)
        
        // Routes of The Week
        ScrollView(.horizontal) {
            // All Image
            HStack {
                ForEach (vm.annotations, id:\.self) { i in
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
                            Image(i.annotationModel.routeName)
                                .resizable()
                                .frame(width: 334, height: 155)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom, 4)
                            
                            VStack (alignment: .leading, spacing: 8) {
                                Text(i.annotationModel.routeName)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                
                                HStack (spacing: 6){
                                    Image("marker pin black")
                                    Text(i.location!)
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.TextDimGray)
                                        .fontWeight(.semibold)
                                }
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                        }.frame(height: 222)
                    }
                    .padding(.vertical, 2)
                    .onTapGesture {
                        vm.selectedAnnotation = i.annotationModel
                        vm.currentDisplayScreen = .viewMap
                        isRouteSelected = true
                    }
                }
            }
            .padding([.leading,.trailing])
        }
        .padding(.bottom)
    }
}

#Preview {
    RoutesOfTheWeek(isRouteSelected: .constant(false))
}
