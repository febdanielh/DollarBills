//
//  TimePickerView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct TimePickerView: View {
    
    @Binding var selectedTime : Double
    
    var body: some View {
        VStack {
            //            Text("Selected Time: \(convertValue(time: selectedValue))")
            
            VStack {
                Picker("Items", selection: $selectedTime) {
                    ForEach(timeIntervals, id:\.self) { i in
                        Text(String(format: "%.0f minutes", i/60))
                            .underline()
                            .tag(i)
                    }
                }
                .font(.title3)
                .bold()
                .tint(.black)
                
                Text("Minute").fontWeight(.semibold)
            }
            
            //                        DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
            //                            .datePickerStyle(WheelDatePickerStyle())
            //                            .frame(width: 240, height: 86)
            //                            .cornerRadius(25)
            //                            .padding()
        }
    }
    private func formattedTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    private func convertValue(time: Int) -> Int {
        let convertedTime = (time * 60)
        return convertedTime
    }
}

#Preview {
    TimePickerView(selectedTime: .constant(600.0))
}
