//
//  PauseRunView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 12/10/23.
//

import SwiftUI

struct PauseRunView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack(spacing: 40){
            MapView(selectedAnnotation: $vm.selectedAnnotation)
                .frame(width: 400, height: 400)
                .foregroundColor(Color.primaryColor01)
                .ignoresSafeArea()
                .shadow(radius: 8)
            HStack(){
                Spacer()
                VStack(spacing: 20){
                    Text("160")
                        .font(.system(size: 20))
                        .bold()
                    Text("BPM")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text("03:40")
                        .font(.system(size: 20))
                        .bold()
                    Text("Duration")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text("7'54")
                        .font(.system(size: 20))
                        .bold()
                    Text("Pace")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
            }
            HStack(){
                Spacer()
                VStack(spacing: 20){
                    Text("1.2 km")
                        .font(.system(size: 20))
                        .bold()
                    Text("Distance")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text("10 m")
                        .font(.system(size: 20))
                        .bold()
                    Text("Elevation")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
                VStack(spacing: 20){
                    Text("110 kcal")
                        .font(.system(size: 20))
                        .bold()
                    Text("Calories")
                        .font(.system(size: 20))
                        .bold()
                }
                Spacer()
            }
            Spacer()
            HStack(spacing: 40){
                Button(action: {
                    print("stop pressed")
                }, label: {
                    Image(systemName: "stop.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.primaryColor01)
                })
                
                Button(action: {
                    print("play pressed")
                }, label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 80.56, height: 80.56)
                        .foregroundColor(.primaryColor01)
                })
            }
            Spacer()
        }
    }
}

#Preview {
    PauseRunView()
}
