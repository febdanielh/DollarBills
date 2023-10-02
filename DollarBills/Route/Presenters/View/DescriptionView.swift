//
//  DescriptionView.swift
//  DollarBills
//
//  Created by Angelica Pinonkuan on 28/09/23.
//

import SwiftUI

struct DescriptionView: View {
    var body: some View {
        
        VStack{
            Text("Description")
                .font(.largeTitle)
            Text("Route Name: Foresta Raya Loop")
            Text("Elevation:")
            Text("Distance:")
            Text("Status: Completed")
        }
        
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
