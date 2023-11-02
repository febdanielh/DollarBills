//
//  RunViewPage1.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunViewPage1: View {
    
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            HStack {
                
                FinishButton()
                
                Spacer()
                
                if isPaused {
                    ResumeButton()
//                    isPaused = true
                }
                else if !isPaused{
                    PauseButton()
//                    isPaused = false
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
    RunViewPage1()
}



struct PauseButton: View {
    var body: some View {
        NavigationLink {
            FinishRunView()
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.purple)
                        .frame(width: 70, height: 60)
                    Image(systemName: "pause.circle")
                        .font(.title)
                }
                Text("Pause")
            }
        }
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
        .buttonStyle(PlainButtonStyle())
    }
}

struct LockButton: View {
    var body: some View {
        
        NavigationLink {
            FinishRunView()
        } label: {
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
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ResumeButton: View {
    var body: some View {
        
        NavigationLink {
            FinishRunView()
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color.green)
                        .frame(width: 70, height: 60)
                    Image(systemName: "play.circle")
                        .font(.title)
                }
                Text("Lock")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
