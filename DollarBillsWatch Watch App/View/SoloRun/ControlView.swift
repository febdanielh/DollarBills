//
//  ControlView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct ControlView: View {
    @State private var isPaused = false
    @Binding var tab: RunTab
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: FinishRunView()) {
                    FinishButton()
                }
                .frame(width: 70, height: 60)
                .buttonStyle(PlainButtonStyle())
                Spacer()
                if isPaused {
                    ResumeButton(isPaused: $isPaused, tab: $tab)
                } else {
                    PauseButton(isPaused: $isPaused, tab: $tab)
                }
            }
            Spacer()
            HStack {
                LockButton(tab: $tab)
                //if lock button is pressed, water lock is activated
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ControlView(tab: .constant(.controlView))
}


struct PauseButton: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPaused : Bool
    @Binding var tab: RunTab
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color("Purple: Pause Button"))
                    .frame(width: 70, height: 60)
                Image(systemName: "pause.circle")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Purple: Pause Icon"))
            }
            Text("Pause")
        }
        .onTapGesture {
            isPaused.toggle()
            workoutManager.pause()
            tab = .mainView
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct ResumeButton: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPaused : Bool
    @Binding var tab: RunTab
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color("Green: Resume Button"))
                    .frame(width: 70, height: 60)
                Image(systemName: "play.circle")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Green: Resume Icon"))
            }
            Text("Resume")
        }
        .onTapGesture {
            isPaused.toggle()
            workoutManager.resume()
            tab = .mainView
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct FinishButton: View {
    
    var body: some View {
        NavigationLink(destination: FinishRunView()) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color("Red: Finish Button"))
                        .frame(width: 70, height: 60)
                    Image(systemName: "flag.checkered")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Red: Finish Icon"))
                }
                Text("Finish")
            }
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct LockButton: View {
    @Binding var tab: RunTab
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color("Blue: Lock Button"))
                    .frame(width: 70, height: 60)
                Image(systemName: "lock")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Blue: Lock Icon"))
            }
            Text("Lock")
        }
        .onTapGesture {
            WKInterfaceDevice.current().enableWaterLock()
            tab = .mainView
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}
