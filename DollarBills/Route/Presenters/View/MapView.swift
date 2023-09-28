//
//  MapView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 28/09/23.
//

import SwiftUI
import MapKit

struct MapView: View {

       var body: some View {
           
           VStack{
               
               RouteView()
                   .frame(height: 400)
                   .edgesIgnoringSafeArea(.top)
                   .padding(.top,-300)
               
               DescriptionView()
           }
          
           
       }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
