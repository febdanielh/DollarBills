//
//  SegmentTabView.swift
//  DollarBills
//
//  Created by Elvis Susanto on 16/10/23.
//

import SwiftUI

struct SegmentTabView: View {
    
    @EnvironmentObject var vm : ViewModel

    let segments: [Segment] = [
        Segment(page: "Explore"),
        Segment(page: "Activity"),
        Segment(page: "Profile")
    ]

    var body: some View {
        
        TabView(selection: $vm.selectedSegment) {
            ForEach(0 ..< segments.count, id: \.self) { index in
                Text("")
                    .tag(index)
                    .tabItem {
                        Image("\(segments[index].page)")
                        Text(segments[index].page)
                    }
            }
        }
        .tint(Color.YellowDark)
        
    }
}

struct Segment {
    let page: String
}
