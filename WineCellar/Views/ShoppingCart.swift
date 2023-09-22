//
//  ShoppingCart.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct ShoppingCart: View {

    @EnvironmentObject var appState: AppState

    let user: User

    var body: some View {
        VStack {
            Text(user.name)
            List(appState.cartItems()) { item in
                ShoppingCartRow(item: item, saveAction: { value in
                    appState.updateCartItem(item, withValue: value)
                })
            }
        }
    }
}

struct ShoppingCart_Previews: PreviewProvider {
    static let user = User(id: UUID(), name: "Nick")
    static var previews: some View {
        ShoppingCart(user: user)
    }
}

