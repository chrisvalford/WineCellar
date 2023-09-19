//
//  User.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: UUID
    let name: String
}
