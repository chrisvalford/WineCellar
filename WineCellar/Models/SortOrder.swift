//
//  SortOrder.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

enum SortOrder: Int, Identifiable, CaseIterable, CustomStringConvertible {
    case none = 0
    case name = 1
    case year = 3
    case price = 4

    var id: SortOrder { return self }

    var description: String {
        switch self {
        case .none:
            return "None"
        case .name:
            return "Name"
        case .year:
            return "Year"
        case .price:
            return "Price"
        }
    }
}
