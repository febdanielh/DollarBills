//
//  ControlView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct ControlView: View {
    
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            HStack {
                FinishButton()
                Spacer()
                if isPaused {
                    ResumeButton(isPaused: $isPaused)
                } else {
                    PauseButton(isPaused: $isPaused)
                }
            }
            Spacer()
            HStack {
                LockButton()
                //if lock button is pressed, water lock is activated
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ControlView()
}


struct PauseButton: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPaused : Bool
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.green)
                    .frame(width: 70, height: 60)
                Image(systemName: "pause.circle")
                    .font(.title)
            }
            Text("Pause")
        }
        .onTapGesture {
            isPaused.toggle()
            workoutManager.pause()
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct ResumeButton: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPaused : Bool
    
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.purple)
                    .frame(width: 70, height: 60)
                Image(systemName: "play.circle")
                    .font(.title)
            }
            Text("Resume")
        }
        .onTapGesture {
            isPaused.toggle()
            workoutManager.resume()
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct FinishButton: View {
    
    var body: some View {
        NavigationLink {
            FinishRunView()
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.red)
                        .frame(width: 70, height: 60)
                    Image(systemName: "flag.checkered")
                        .font(.title)
                }
                Text("Finish")
            }
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}

struct LockButton: View {
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.blue)
                    .frame(width: 70, height: 60)
                Image(systemName: "drop.fill")
                    .font(.title)
            }
            Text("Lock")
        }
        .onTapGesture {
            WKInterfaceDevice.current().enableWaterLock()
        }
        .frame(width: 70, height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}
