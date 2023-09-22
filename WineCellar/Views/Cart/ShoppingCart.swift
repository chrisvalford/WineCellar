//
//  ShoppingCart.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct ShoppingCart: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var appState: AppState
    @State private var isShowingInfo = false

    @State private var cartCount = 0

    let user: User

    var body: some View {
        VStack {
            Text(user.name)
            List(appState.cartItems()) { item in
                ShoppingCartRow(item: item, saveAction: { value in
                    appState.updateCartItem(item, withValue: value)
                })
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $isShowingInfo) {
            ShoppingCartInfo()
        }
        .toolbar {
            Button(action: {
                isShowingInfo = true
            }, label: {
                Image(systemName: "info.circle")
            })
        }
        .navigationTitle(cartCount < 2 ? "Shopping Cart" : "Shopping Carts")
        .onAppear {
            let cartModel = CartModel()
            cartCount = cartModel.cartCount
        }
    }
}

struct ShoppingCart_Previews: PreviewProvider {
    static let user = User(id: UUID(), name: "Nick")
    static var previews: some View {
        ShoppingCart(user: user)
    }
}

