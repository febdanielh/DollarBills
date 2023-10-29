//
//  MapView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 04/10/23.
//

import SwiftUI

struct MapView: View {
    
    @State var showDirections: Bool = false
    
    @Binding var selectedAnnotation: AnnotationModel
    @Binding var directions: [String]
    @Binding var tag: Int
    
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var vm: ViewModel
    @AppStorage("launchedBefore") var launchedBefore = false
    @State var welcome = false
    
    @Binding var isRouteSelected: Bool
    @Binding var selectedRoute: Routes
    
    var body: some View {
        ZStack{
//            Color.SheetGray.ignoresSafeArea()
            VStack{
                ZStack {
                    createMap(
                        directions: $directions,
                        routes: $vm.routes,
                        selectedAnnotation: $selectedAnnotation,
                        cachedDirections: $vm.cachedDirections
                    )
                    .frame(height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
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
                
                RouteCards(selectedAnnotation: $selectedAnnotation, tag: $tag, isRouteSelected: $isRouteSelected, selectedRoute: $selectedRoute)
            }
        }
        .sheet(isPresented: $isRouteSelected, content: {
            routeSheet(selectedAnnotation: $selectedAnnotation, directions: $directions, isRouteSelected: $isRouteSelected)
        })
    }
}
