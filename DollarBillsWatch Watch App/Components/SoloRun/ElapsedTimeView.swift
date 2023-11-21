//
//  ElapsedTimeView.swift
//  DollarBillsWatch Watch App
//
//  Created by Abiyyu Firmansyah on 08/11/23.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    @State private var timeFormatter = ElapsedTimeFormatter()

    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .fontWeight(.semibold)
    }
}

class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }

        return componentsFormatter.string(from: time)
    }
    
    static func formatElapsedTime(_ time: TimeInterval) -> String {
        let formatter = ElapsedTimeFormatter()
        return formatter.string(for: time) ?? "00:00:00"
    }
}
