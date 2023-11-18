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
            LandingPageView()
        }
    }
}

struct LandingPageView: View {
    
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack (alignment: .leading) {
                    
                    Text("Near You")
                        .font(.headline)
                    
                    ForEach(0..<2, id: \.self) { _ in
                        
                        NavigationLink(destination: RouteDetailView()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 150, height: 50)
                                    .foregroundStyle(Color.yellow)
                                Text("Mozia Loop")
                                    .foregroundStyle(Color.black)
                            }
                        }
//                        NavigationLink {
//                            RouteDetailView()
//                        } label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 25)
//                                    .frame(width: 150, height: 50)
//                                    .foregroundStyle(Color.yellow)
//                                Text("Mozia Loop")
//                                    .foregroundStyle(Color.black)
//                            }
//                        }
                        .frame(width: 150, height: 50)
                        .padding(.top,3)
                        .padding(.horizontal)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Text("Recent")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ForEach(0..<2, id: \.self) { _ in
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 150, height: 50)
                                    .foregroundStyle(Color.yellow)
                                Text("Mozia Loop")
                                    .foregroundStyle(Color.black)
                            }
                        }
                        .frame(width: 150, height: 50)
                        .padding(.top,3)
                        .padding(.horizontal)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    LandingPageView()
}
