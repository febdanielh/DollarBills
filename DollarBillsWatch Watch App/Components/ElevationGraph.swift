//
//  ElevationGraph.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 29/10/23.
//

import SwiftUI

struct ElevationGraph: View {
    let elevationData: [Double] = [30, 40, 10, 30, 20, 15, 50, 10, 40]
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
//            let height: CGFloat = 20
            
            Path { path in
                let dataCount = elevationData.count
                
                for i in 0..<dataCount {
                    let x = width * CGFloat(i) / CGFloat(dataCount - 1)
                    let y = height - CGFloat(elevationData[i]) // Invert for proper rendering
                    if i == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                
                for i in stride(from: dataCount - 1, through: 0, by: -1) {
                    let x = width * CGFloat(i) / CGFloat(dataCount - 1)
                    let y = height
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .fill(Color.yellow.opacity(0.5)) // Fill color and opacity
            .overlay(Path { path in
                let dataCount = elevationData.count
                
                for i in 0..<dataCount {
                    let x = width * CGFloat(i) / CGFloat(dataCount - 1)
                    let y = height - CGFloat(elevationData[i]) // Invert for proper rendering
                    if i == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.yellow, lineWidth: 2))
        }
    }
}

#Preview {
    ElevationGraph()
}
