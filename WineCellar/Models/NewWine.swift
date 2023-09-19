//
//  NewWine.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

struct NewWine: Identifiable, Hashable {
    let name: String
    var id: String { return name }
}
