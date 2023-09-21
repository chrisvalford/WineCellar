//
//  WineModelInterface.swift
//  WineCellar
//
//  Created by Christopher Alford on 20/9/23.
//

import Foundation

protocol WineModelInterface {
    func create(wine: Wine) throws
    func delete(wine: Wine) throws
    func fetch(wine: Wine) throws -> Wine?
    func all() throws -> [Wine]
    func update(wine: Wine) throws
    func fetch(query: [Int], sortBy: SortOrder) throws -> [Wine]
}
