//
//  CartType.swift
//  WineCellar
//
//  Created by Christopher Alford on 22/9/23.
//

import Foundation

enum CartType: Int, Identifiable, CaseIterable, CustomStringConvertible {
    case unknown = 0
    case wishList = 1
    case supermarket = 2
    case smallSupplier = 3
    case producer = 4
    case vinyard = 5
    case warehouse = 6

    var id: CartType { return self }

    var description: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .wishList:
            return "Wish list"
        case .supermarket:
            return "Supermarket"
        case .smallSupplier:
            return "Supplier"
        case .producer:
            return "Producer"
        case .vinyard:
            return "Vinyard"
        case .warehouse:
            return "Warehouse"
        }
    }
}
