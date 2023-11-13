//
//  TimePicker.swift
//  DollarBills
//
//  Created by Febrian Daniel on 09/11/23.
//
import SwiftUI
import UIKit

struct Time {
    var hour: Int
    var minute: Int
    var second: Int = 0
}

struct DurationPickerView: UIViewRepresentable {
    @Binding var time: Time

    func makeCoordinator() -> DurationPickerView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.onDateChanged), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        let date = Calendar.current.date(bySettingHour: time.hour, minute: time.minute, second: time.second, of: datePicker.date)!
        datePicker.setDate(date, animated: true)
    }

    class Coordinator: NSObject {
        var durationPicker: DurationPickerView

        init(_ durationPicker: DurationPickerView) {
            self.durationPicker = durationPicker
        }

        @objc func onDateChanged(sender: UIDatePicker) {
            print(sender.date)
            let calendar = Calendar.current
            let date = sender.date
            let time = Time(hour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: date), second: calendar.component(.second, from: date))
            let totalDuration = convertTimeToDouble(time)
        }
        
        func convertTimeToDouble(_ time: Time) -> Double {
            let totalSeconds = Double(time.hour * 3600 + time.minute * 60 + time.second)
            return totalSeconds
        }
    }
}
