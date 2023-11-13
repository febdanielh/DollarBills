//
//  NearestToYouDetailView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 20/10/23.
//

import SwiftUI

struct NearestToYouDetailView: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var tag: Int
    var body: some View {
        ZStack {
            Color.SheetGray
                .ignoresSafeArea()
            VStack {
                Text("Nearest To You")
                    .font(.system(size: 20))
                    .bold()
                
                Divider()
                
                NearestRouteDetailCard(tag: $tag)
            }
        }
    }
}

#Preview {
    NearestToYouDetailView(tag: .constant(0))
}
