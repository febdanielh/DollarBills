//
//  RunView.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 12/10/23.
//

import SwiftUI

struct RunView: View {
    
    let workout: Workout
    
    @EnvironmentObject var vm: ViewModel
    
    @State var runImage: String = "spruto lari"
    @State var runDescription: String = "Run and collect items"
    
    @Binding var itemCollected: [Items]
    
    @State var isGif: Bool = true
    
    var progressValue: Double {
        return workout.distance / 500.0
    }
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack {
                    Text("- -")
                        .bold()
                    Text("BPM")
                        .font(.system(size: 20)).fontWeight(.medium)
                }
                Spacer()
                VStack {
                    Text(workout.formattedDuration())
                        .bold()
                    Text("Duration")
                        .font(.system(size: 20)).fontWeight(.medium)
                }
                Spacer()
                VStack {
                    Text(workout.formattedPace())
                        .bold()
                    Text("Pace")
                        .font(.system(size: 20)).fontWeight(.medium)
                }
            }
            
            Spacer()
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 200)
                        .fill(Color(red: 1, green: 0.54, blue: 0))
                        .frame(width: 59, height: 20)
                    Text("Target")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                Text(workout.formattedDistance())
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(Color(red: 0.18, green: 0.19, blue: 0.2))
                
            }.padding(.bottom, 20)
            
            VStack {
                if isGif {
                    GifImage(name: runImage)
                        .frame(width: 220, height: 220)
                        .padding()
                } else {
                    Image(runImage)
                        .padding()
                }
            }.onReceive(vm.$itemCollected, perform: { items in
                if let lastItem = items.last {
                    runImage = lastItem.image
                    runDescription = "You obtain a \(lastItem.namaItem). Finish the route to claim it"
                    isGif = false
                }
            })
            
            Text(runDescription)
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .italic()
                .foregroundColor(Color.TextDimGray)
                .padding(.horizontal, 10)
                .padding(.bottom)
            
            ProgressView(value: progressValue, label: { Text("Your Progress") }, currentValueLabel: { Text("\(Int(progressValue * 100))%") })
                .progressViewStyle(BarProgressStyle(height: 25.0))
            
            HStack(spacing: 30){
                Image(systemName: "stop.circle.fill")
                    .resizable()
                    .frame(width: 80.56, height: 80.56)
                    .foregroundColor(.redStopButton)
                    .onTapGesture {
                        print("stop pressed")
                    }
                
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .frame(width: 81, height: 81)
                    .foregroundStyle(Color.YellowNormal2)
                    .onTapGesture {
                        vm.currentDisplayScreen = .viewPause
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(30)
    }
}

#Preview {
    ProgressView(value: 0.5, label: { Text("Your Progress") }, currentValueLabel: { Text("\(Int(0.5 * 100))%") })
        .progressViewStyle(BarProgressStyle(height: 25.0))
}
