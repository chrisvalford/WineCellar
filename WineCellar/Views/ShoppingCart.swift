//
//  ShoppingCart.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct ShoppingCart: View {

    let user: User

    var body: some View {
        Text(user.name)
    }
}

struct ShoppingCart_Previews: PreviewProvider {
    static let user = User(id: UUID(), name: "Nick")
    static var previews: some View {
        ShoppingCart(user: user)
    }
}
