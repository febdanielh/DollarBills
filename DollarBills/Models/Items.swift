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
    var image: String
//    var effect: String
}

struct ItemsData {
    //item dummy
    static let item = [
        Items(namaItem: "Blue Potion",
              image: "0Potion"),
        
        Items(namaItem: "Rock",
              image: "1Rock"),
        
        Items(namaItem: "Red Potion",
              image: "2Potion"),
        
        Items(namaItem: "Three Rocks",
              image: "3Rock")
    ]
}
