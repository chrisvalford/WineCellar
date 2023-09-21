//
//  ShoppingCartRow.swift
//  WineCellar
//
//  Created by Christopher Alford on 21/9/23.
//

import SwiftUI

struct ShoppingCartRow: View {
    let item: CartItem

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer()
                Text(item.year)
            }
            Text(item.wineType.description)
            HStack {
                Text("Quantity: ")
                Text("\(item.quantity)")
            }
        }
    }
}

//#Preview {
//    ShoppingCartRow()
//}
