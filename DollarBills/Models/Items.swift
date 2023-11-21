//
//  Items.swift
//  DollarBills
//
//  Created by Febrian Daniel on 05/10/23.
//

import Foundation
import SwiftUI

struct Items: Identifiable, Codable, Hashable {
    var id = UUID()
    var namaItem: String
    var image: String
    var desc: String
}

struct ItemsData {
    //item dummy
    static let item = [
        Items(namaItem: "Blue Potion",
              image: "0Potion",
              desc: "Double up your distance for 10 seconds"),
        
        Items(namaItem: "Rock",
              image: "3Rock",
              desc: "Freeze opponent's distance by 10 seconds"),
        
        Items(namaItem: "Red Potion",
              image: "2Potion",
              desc: "Divide opponent's distance by half for 10 seconds"),
        
        Items(namaItem: "White Flag",
              image: "whiteFlag",
              desc: "Add 200 m to your distance"),
        
        Items(namaItem: "Bomb",
              image: "bomb",
              desc: "Reduce opponent's distance by 200 m")
    ]
}
