//
//  CartItem.swift
//  WineCellar
//
//  Created by Christopher Alford on 21/9/23.
//

import Foundation

struct CartItem: Identifiable {
    var id: UUID { identifier }
    let identifier: UUID
    let name: String
    var year: String
    var wineType: WineType
    var quantity: Int
}
