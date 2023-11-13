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
    var phoneToWatch = PhoneToWatch()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if countdown > 0 {
                Text("\(countdown)")
                    .font(.largeTitle)
                    .bold()
                    .onReceive(timer) { _ in
                        if countdown > 0 {
                            countdown -= 1
                        } else {
                            print("Countdown finished!")
                        }
                    }
            }
            else {
                Text("")
                    .bold()
                    .font(.largeTitle)
                    .onAppear(perform: {
                        phoneToWatch.sendMessageToWatch()
                        vm.currentDisplayScreen = .viewRun
//                        Task {
//                            await vm.startWorkout(type: .running)
//                        }
                    })
            }
        }
    }
}

#Preview {
    CountdownView()
}
