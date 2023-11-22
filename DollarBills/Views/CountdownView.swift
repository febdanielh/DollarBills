//
//  CountdownView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 21/10/23.
//

import SwiftUI

struct CountdownView: View {
    
    @State private var countdown = 3
    @EnvironmentObject var vm: ViewModel
    @ObservedObject var phoneToWatch = PhoneToWatch()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var foreGroundColor = Color.YellowLight3
    
    let colors: [Color] = [Color.YellowNormal, Color.YellowNormal2]
    
    var body: some View {
        VStack {
            if countdown > 0 {
                ZStack {
                    Circle()
                        .frame(width: 300 + CGFloat(countdown) * 40, height: 300 + CGFloat(countdown) * 40)
                        .foregroundColor(foreGroundColor)
                    Text("\(countdown)")
                        .font(.system(size: 180))
                        .fontWeight(.black)
                        .onReceive(timer) { _ in
                            if countdown > 0 {
                                countdown -= 1
                                foreGroundColor = colors[countdown % colors.count]
                            } else {
                                print("Countdown finished!")
                            }
                        }
                }
            }
            else {
                Text("")
                    .onAppear(perform: {
                        phoneToWatch.sendMessageToWatch()
                        Task {
                            await vm.startWorkout(type: .running)
                        }
                        vm.currentDisplayScreen = .viewRun
                    })
            }
        }
    }
}

#Preview {
    CountdownView()
}
