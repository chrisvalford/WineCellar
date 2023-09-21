//
//  CartItem.swift
//  WineCellar
//
//  Created by Christopher Alford on 21/9/23.
//

import Foundation

struct CartItem: Identifiable {
    var id: String { return name }
    let name: String
    var year: String
    var wineType: WineType
    var quantity: Int
}
