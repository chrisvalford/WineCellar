//
//  WineType.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

enum WineType: Int, Identifiable, CaseIterable, CustomStringConvertible {
    case unknown = 0
    case white = 1
    case red = 2
    case rose = 3
    case sparkling = 4
    case cava = 5

    var id: WineType { return self }

    var description: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .white:
            return "Blanco"
        case .red:
            return "Tinto"
        case .rose:
            return "Rośe"
        case .sparkling:
            return "Sparling"
        case .cava:
            return "Cava"
        }
    }
}
