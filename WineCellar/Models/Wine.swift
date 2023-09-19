//
//  Wine.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

struct Wine: Identifiable, Hashable {
    let name: String
    var year: String
    var id: String { return name }
}
