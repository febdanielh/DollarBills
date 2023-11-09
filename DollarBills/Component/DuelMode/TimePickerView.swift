//
//  TimePickerView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct TimePickerView: View {
    
    @State private var selectedTime = Date()
    @State private var selectedValue = 0
    
    let values = [1, 5, 20, 30, 60]
    
    var body: some View {
        VStack {
            //            Text("Selected Time: \(convertValue(time: selectedValue))")
            
            HStack {
                Picker("", selection: $selectedValue) {
                    ForEach(0 ..< values.count) {
                        var choice = self.values[$0]
                        Text("\(choice)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
                .clipped()
                
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
    TimePickerView()
}
