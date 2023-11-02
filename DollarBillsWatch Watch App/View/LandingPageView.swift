//
//  LandingPageView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    
                    Text("Near You")
                        .font(.headline)
                    
                    ForEach(0..<2, id: \.self) { _ in
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 150, height: 50)
                                .foregroundStyle(Color.yellow)
                            Text("Mozia Loop")
                        }
                        .padding(.top,3)
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    Text("Recent")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ForEach(0..<2, id: \.self) { _ in
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            Text("Mozia Loop")
                        }
                        .foregroundStyle(Color.yellow)
                        .padding(.top,3)
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
