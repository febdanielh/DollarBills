//
//  ViewExt.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import SwiftUI

struct Background: ViewModifier {
    
     @Environment(\.colorScheme) var colorScheme
    
     var background: Material { colorScheme == .light ? .regularMaterial: .thickMaterial }
    
     func body(content: Content) -> some View {
         content
             .background(background)
             .cornerRadius(10)
             .compositingGroup()
             .shadow(color: Color(.systemFill), radius: 5)
     }
}

extension View {
     
     func materialBackground() -> some View {
         self.modifier(Background())
     }
    
    @ViewBuilder
    func `if`<Content: View>(_ applyModifier: Bool = true, @ViewBuilder content: (Self) -> Content) -> some View {
        if applyModifier {
            content(self)
        } else {
            self
        }
    }
    
     func horizontallyCentred() -> some View {
         HStack {
             Spacer(minLength: 0)
             self
             Spacer(minLength: 0)
         }
     }
    
     func bigButton() -> some View {
         self
             .font(.body.bold())
             .padding()
             .horizontallyCentred()
             .foregroundColor(.white)
             .background(Color.accentColor)
             .cornerRadius(15)
     }
}

struct GetMonthYear {
    func getMonth() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        
        return nameOfMonth
    }

    func getYear() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentYear = dateFormatter.string(from: now)
        
        return currentYear
    }
}
