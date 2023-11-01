//
//  VerticalTabView.swift
//  DollarBillsWatch Watch App
//
//  Created by Angelica Pinonkuan on 01/11/23.
//

import SwiftUI

struct VerticalTabView: View {
    
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            HStack {
                // Sidebar (Vertical Tab Bar)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Menu").font(.headline).padding(.leading, 15)
                    Divider()
                    TabItem("Tab 1", systemImage: "house.fill", tag: 0)
                    TabItem("Tab 2", systemImage: "heart.fill", tag: 1)
                    TabItem("Tab 3", systemImage: "person.fill", tag: 2)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.yellow)

                // Content View
                TabView(selection: $selectedTab) {
                    Text("Tab 1 Content").tag(0)
                    Text("Tab 2 Content").tag(1)
                    Text("Tab 3 Content").tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
}

@ViewBuilder
func TabItem(_ label: String, systemImage: String, tag: Int) -> some View {
    NavigationLink(
        destination: Text("Placeholder for \(label) Content").navigationBarTitle(label),
        tag: tag,
        selection: $selectedTab
    ) {
        Label(label, systemImage: systemImage)
    }
}

#Preview {
    VerticalTabView()
}
