//
//  Route.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import Foundation

enum Route: Hashable {
    case wine(Wine)
    case newWine(NewWine)
    case shoppingCart(User)
    case search(String)
}
