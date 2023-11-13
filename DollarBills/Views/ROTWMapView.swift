//
//  ROTWMapView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 07/11/23.
//

import SwiftUI

struct ROTWMapView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    
    @Binding var selectedAnnotation: AnnotationModel
    @Binding var directions: [String]
    
    @State var currentRouteIndex: Int = 0
    @Binding var isRouteSelected: Bool
    @Binding var selectedRoute: Routes
    
    var body: some View {
        VStack{
            ZStack {
                createMap(
                    directions: $directions,
                    routes: $vm.routes,
                    selectedAnnotation: $selectedAnnotation,
                    cachedDirections: $vm.cachedDirections
                )
                .ignoresSafeArea()
                .frame(height: 410)
            }
            .fullScreenCover(isPresented: $vm.healthUnavailable) {
                ErrorView(systemName: "heart.slash", title: "Health Unavailable", message: "\(NAME) needs access to the Health App to store and load workouts. Unfortunately, this device does not have these capabilities so the app will not work.")
            }
            .sheet(isPresented: $vm.showPermissionsView) {
                PermissionsView()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    vm.updateHealthStatus()
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isRouteSelected, onDismiss: {
            vm.currentDisplayScreen = .viewMain
        }, content: {
            ROTWSheet(selectedAnnotation: $selectedAnnotation, directions: $directions, isRouteSelected: $isRouteSelected, currentRouteIndex: $currentRouteIndex)
        })
    }
}

//
//#Preview {
//    ROTWMapView(selectedAnnotation: <#Binding<AnnotationModel>#>, directions: <#Binding<[String]>#>, isRouteSelected: <#Binding<Bool>#>, selectedRoute: <#Binding<Routes>#>)
//}
