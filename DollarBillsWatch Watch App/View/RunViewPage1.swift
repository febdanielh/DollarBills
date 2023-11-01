//
//  RunViewPage1.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 30/10/23.
//

import SwiftUI

struct RunViewPage1: View {
    var body: some View {
        VStack {
            HStack {
                FinishButton()
                Spacer()
                PauseButton()
                
            }
            Spacer()
            HStack {
                LockButton()
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

        
    }
}

struct LockButton: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.blue)
                    .frame(width: 70, height: 60)
                Image(systemName: "lock.fill")
                    .font(.title)
            }
            Text("Lock")
        }
    }
}

struct ResumeButton: View {
    var body: some View {
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
}
