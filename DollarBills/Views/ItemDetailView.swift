//
//  File.swift
//  DollarBills
//
//  Created by Elvis Susanto on 27/10/23.
//

import Foundation
import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    @State var selectedItem: Items = ItemsData.item[0]
    
    @State var selectedIndex: Int = 0
    {
        didSet {
            selectedItem = ItemsData.item[selectedIndex]
        }
    }
    
    var body: some View {
        
        VStack {
            
            Divider()
            
            Spacer()
            
            ZStack {
                
                Color.WPBG
                    .ignoresSafeArea()
                
                VStack {
                    
                    ZStack {
                        
                        Image(selectedItem.image)
                            .resizable()
                            .frame(width: 220, height: 160)
                        
                        VStack (alignment: .trailing) {
                            
                            Spacer()
                            
                            HStack {
                                
                                Spacer()
                                
                                ZStack {
                                    
                                    Image("x1")
                                        .resizable()
                                        .frame(width: 50, height: 23)
                                    Text("x1")
                                        .foregroundStyle(.white)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                    
                                }
                                
                            }
                            
                            
                        }
                        .frame(width: 107, height: 150)
                        
                    }
                    
                    Text(selectedItem.namaItem)
                        .font(.title2)
                        .bold()
                        .padding()
                    
                    Text(selectedItem.desc)
                        .frame(width: 310)
                        .multilineTextAlignment(.center)
                    
                }
                .frame(height: 350)
                
            }
            
            Spacer()
            
            ZStack {
                UnevenRoundedRectangle(topLeadingRadius: 16, topTrailingRadius: 16)
                    .foregroundStyle(.white)
                    .frame(height: 230)
                    .shadow(radius: 5)
                    .mask(Rectangle().padding(.top, -20))
                
                VStack {
                    
                    HStack {
                        
                        Text("Items")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Text("5/30")
                            .padding()
                            .font(.headline)
                            .foregroundStyle(Color.black)
                            .frame(height: 26, alignment: .center)
                            .background(
                                Color.YellowNormal)
                            .cornerRadius(16.0)
                            .overlay (
                                RoundedRectangle(cornerRadius: 16.0)
                                    .stroke(Color.YellowNormal, lineWidth: 0)
                            )
                        
                    }
                    .frame(width: 330)
                    .padding(.bottom)
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            ForEach(0 ..< 4) { i in
                                
                                Button(action: {
                                    
                                    selectedIndex = i
                                    
                                }, label: {
                                    
                                    ZStack {
                                        
                                        if (selectedIndex == i) {
                                            RoundedRectangle(cornerRadius: 11)
                                                .frame(width: 108, height: 114)
                                                .foregroundStyle(Color.YellowLight1)
                                        } else {
                                            RoundedRectangle(cornerRadius: 11)
                                                .frame(width: 108, height: 114)
                                                .foregroundStyle(Color.WPBG)
                                        }
                                        
                                        
                                        if (i % 2 == 0) {
                                            Image("\(i)Potion")
                                                .resizable()
                                                .frame(width: 120, height: 90)
                                        }
                                        else {
                                            Image("\(i)Rock")
                                                .resizable()
                                                .frame(width: 120, height: 90)
                                        }
                                        
                                        VStack (alignment: .trailing) {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                ZStack {
                                                    
                                                    Image("x1")
                                                        .resizable()
                                                        .frame(width: 54, height: 25)
                                                    Text("x1")
                                                        .foregroundStyle(.white)
                                                        .font(.title3)
                                                        .fontWeight(.semibold)
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        .frame(width: 110, height: 115)
                                        
                                    }
                                    
                                })
                                
                            }
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding([.leading, .trailing, .bottom])
                        
                    }
                    
                }
                
            }
            
            Spacer()
            
        }
        .navigationBarTitle(Text("Items"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ItemDetailView()
        .environmentObject(ViewModel())
}
