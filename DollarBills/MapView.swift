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
                selectedAnnotation: $selectedAnnotation)
            .ignoresSafeArea()
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("Show Directions")
            })
            .disabled(directions.isEmpty)
            .padding()
        }
        .sheet(isPresented: $showDirections, content: {
            VStack {
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Divider()
                List{
                    ForEach(directions.indices, id: \.self) { i in
                        Text(directions[i])
                            .padding()
                    }
                }
            }
        })
    }
}

//#Preview {
//    MapView(, selectedAnnotation: <#Binding<AnnotationModel?>#>)
//}
