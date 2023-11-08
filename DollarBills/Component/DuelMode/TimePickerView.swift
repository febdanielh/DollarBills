//
//  TimePickerView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 07/11/23.
//

import SwiftUI

struct TimePickerView: View {
    
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack {
            Text("Selected Time: \(formattedTime(selectedTime))")
            
            DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .frame(width: 240, height: 86)
                .cornerRadius(25)
                .padding()
            
                
        }
    }
    private func formattedTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

#Preview {
    TimePickerView()
}
