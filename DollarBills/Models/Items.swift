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
    var desc: String
//    var effect: String
}

struct ItemsData {
    //item dummy
    static let item = [
        Items(namaItem: "Blue Poison",
              image: "0Potion", desc: "Blue Poison can reduce opponent’s distance by 5 m"),
        
        Items(namaItem: "Rock",
              image: "1Rock", desc: "Rock can freeze opponent for 5s and reduce the amount of distance gain within 5s"),
        
        Items(namaItem: "Red Poison",
              image: "2Potion", desc: "Red Poison can reduce opponent’s distance by 10 m"),
        
        Items(namaItem: "Three Rocks",
              image: "3Rock", desc: "3 Rocks can freeze opponent for 10 s and reduce the amount of distance gain within 10 s")
    ]
}
