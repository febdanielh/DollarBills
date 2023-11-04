//
//  LeaderboardView.swift
//  CobaInterface
//
//  Created by Elvis Susanto on 20/10/23.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
    
    @EnvironmentObject var VM : ViewModel
    
    var body: some View {
        ScrollView {
            VStack() {
                HStack{
                    Text("October 2023")//ini bisa di ubah? atau menyesuaikan dengan bulan
                        .font(.title3).fontWeight(.semibold)
                    Spacer()
                    NavigationLink {
                        LeaderboardDetailView()
                    } label: {
                        Text("See All >")
                            .font(.subheadline).fontWeight(.semibold)
                            .foregroundStyle(Color.TextDimGray)
                    }
                }.padding([.horizontal, .bottom])
                
                HStack(spacing: 6) {
                    Text("1").font(.footnote)
                        .foregroundColor(Color.YellowDark25)
                    Circle()
                        .frame(height: 11)
                        .foregroundColor(Color.YellowNormal)
                    Text("= 1 m").font(.footnote)
                }
                .padding(.horizontal, 20).padding(.vertical, 4)
                .background(Color.YellowLight23)
                .clipShape(RoundedRectangle(cornerRadius: 200))
                .overlay(
                    RoundedRectangle(cornerRadius: 200)
                        .stroke(Color.YellowDark23)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        LeaderboardBar(points: 500, rank: 2, name: "Feb")
                        LeaderboardBar(points: 800, rank: 1, name: "Pis")
                        LeaderboardBar(points: 300, rank: 3, name: "Rez")
                    }.frame(width: 324)
                }
                .frame(width: 340, height: 410, alignment: .center)
                .padding()
                
                Spacer().frame(height: 100)
                
                ZStack {
                    Rectangle()
                        .frame(height: 61)
                        .foregroundColor(Color.YellowLight23)
                    HStack {
                        Image("leaderboard triangle")
                        Text("You")
                            .font(.body).bold()
                            .padding(.leading, 15)
                        Spacer()
                        HStack {
                            Image("coin")
                            Text("15000")
                                .font(.headline)
                                .foregroundColor(Color.YellowDark26)
                        }
                        .frame(width: 151, height: 42)
                        .background(Color.YellowLight2)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.YellowLight22)
                        )
                        .cornerRadius(8)
                        .padding(.trailing, 30)
                    }
                }.padding(.top)
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
