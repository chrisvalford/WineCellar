//
//  WineType.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

enum WineType: Int, Identifiable, CaseIterable, CustomStringConvertible {
    case white = 0
    case red = 1
    case rose = 3
    case sparkling = 4
    case cava = 5

    var id: WineType { return self }

    var description: String {
        switch self {
        case .white:
            return "White"
        case .red:
            return "Red"
        case .rose:
            return "Rośe"
        case .sparkling:
            return "Sparling"
        case .cava:
            return "Cava / Champagne"
        }
    }
}
