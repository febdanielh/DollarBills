//
//  HeartRate.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 24/10/23.
//

import Foundation
import SwiftUI

class HeartRate: Dimension {
    
    static let beatsPerMinute = HeartRate(symbol: "bpm", converter: UnitConverterLinear(coefficient: 1.0/60.0))
    
    override class func baseUnit() -> Self {
        return beatsPerMinute as! Self
    }
}
