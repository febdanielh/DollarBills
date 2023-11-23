//
//  NeededType.swift
//  DollarBillsWatch Watch App
//
//  Created by Elvis Susanto on 16/11/23.
//

import Foundation
struct WorkoutPayload: Codable {
    let workoutID: UUID?
    let userID: UUID?
    let startDate: Date
    let endDate: Date
    let distance: Double
    let pace: Double
    let duration: Double
}
