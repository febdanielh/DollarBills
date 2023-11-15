//
//  LandingPageView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

enum DisplayScreen {
    case viewHome
    case viewRun
}

struct ContentView: View {
    @EnvironmentObject var wm: WorkoutManager
    @StateObject var locationManager = LocationManager()
    var body: some View {
        switch  wm.currentDisplayScreen {
        case .viewRun:
            RunViewTab()
        default:
            LandingPageView(routes: RouteData.routeData)
        }
    }
}

struct LandingPageView: View {
    var routes: [Routes]
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack (alignment: .leading) {
                    
                    Text("Near You")
                        .font(.headline)
                    
                    ForEach(routes.prefix(2)) { route in
                        NavigationLink(destination: RouteDetailView(route: route)) {
                            NearestRouteCard(routes: route)
                        }
                        .padding(.top,3)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Text("Recent")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    NavigationLink(destination: RouteDetailView(route: routes[3])) {
                            RecentRouteCard(routes: routes[3])
                        }
                        .padding(.top,3)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    LandingPageView(routes: RouteData.routeData)
}
