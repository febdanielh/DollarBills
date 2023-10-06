//
//  WorkoutDate.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import Foundation

enum WorkoutDate: String, CaseIterable {
     case thisWeek = "This Week"
     case thisMonth = "This Month"
     case thisYear = "This Year"
    
     var granularity: Calendar.Component {
         switch self {
         case .thisWeek:
             return .weekOfMonth
         case .thisMonth:
             return .month
         case .thisYear:
             return .year
         }
     }
}
