//
//  MapView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    @State private var directions: [String] = []
    
    @State private var showDirections: Bool = false
    
    @Binding var selectedAnnotation: AnnotationModel?
    
    var body: some View {
        VStack {
            createMap(
                directions: $directions,
                region: locationManager.region,
                selectedAnnotation: $selectedAnnotation,
                showDirections: $showDirections
            )
            .ignoresSafeArea()        }
        .sheet(isPresented: $showDirections, content: {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text(selectedAnnotation!.routeName)
                        .font(.largeTitle)
                        .bold()
                        .padding([.top, .horizontal])
                        .padding(.bottom,15)
                    HStack(spacing: 20){
                        HStack{
                            Image("Flag")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("5 km")
                        }
                        HStack{
                            Image("Clock")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("40 min - 1 hr")
                        }
                        HStack{
                            Image("Running Shoes")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Pavement")
                        }
                    }
                    .padding([.leading, .bottom])
                } .padding([.top, .leading])
                Divider()
                List{
                    ForEach(directions.indices, id: \.self) { i in
                        Text(directions[i])
                            .padding()
                    }
                }
            }
            .presentationDetents([.medium, .large, .fraction(0.16)])
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled(true)
        })
    }
}
