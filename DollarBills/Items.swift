//
//  Items.swift
//  DollarBills
//
//  Created by Febrian Daniel on 05/10/23.
//

import Foundation
import SwiftUI

struct Items: Identifiable {
    var id = UUID()
    var namaItem: String
    var points: Int
    var image: String
}

struct ItemsData {
    //item dummy
    static let item = [
        Items(namaItem: "Kayu",
              points: 1000,
              image: ""),
        Items(namaItem: "Diamond",
              points: 3000,
              image: ""),
        Items(namaItem: "Daun",
              points: 500,
              image: "")
    ]
}
