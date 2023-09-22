//
//  CartModelInterface.swift
//  WineCellar
//
//  Created by Christopher Alford on 20/9/23.
//

import Foundation

protocol CartModelInterface {
    func create(wine: Wine) throws
    func delete(wine: Wine) throws
    func all() throws -> [CartItem]
    func update(wine: Wine) throws
}
