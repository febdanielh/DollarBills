//
//  CreateRoomView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct CreateRoomView: View {
    @State var duration: Time = Time(hour: 0, minute: 0, second: 0)
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack {
            Text("Duel Mode")
                .font(.headline).bold()
                .padding()
            
            Divider()
            ZStack {
                Color.SheetGray
                ScrollView {
                    Spacer().frame(height: 59)
                    VStack(spacing: 26) {
                        Text("Monday, 15 October 2023")
                            .padding(.top)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 160, height: 36)
                                .foregroundColor(Color.yellow)
                            Text("Choose Duration")
                        }
                        
                        
//                        TimePickerView()
//                            .padding(.top, 50)
                        
                        DurationPickerView(time: $duration)
                            .padding(.top, 50)
                        
                        let duration = duration
                        
                        NavigationLink {
                            LobbyView()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(width: 326, height: 44)
                                    .foregroundStyle(Color.black)
                                Text("Create Room")
                                    .foregroundStyle(Color.white)
                                    .font(.title3)
                            }
                        }
                        .onTapGesture {
                        }
                        .padding(.top, 80)
                    }
                }
            }
        }
    }
}

#Preview {
    CreateRoomView()
}
