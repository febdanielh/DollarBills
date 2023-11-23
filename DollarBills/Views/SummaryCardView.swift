//
//  SummaryCardView.swift
//  DollarBills
//
//  Created by Elvis Susanto on 19/11/23.
//

import Foundation
import SwiftUI

struct SummaryCardView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack {
            
        }
        
    }
    
}

struct OneWorkoutCard: View {
    let workout: Workout
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    SummaryCardView().environmentObject(ViewModel())
}
