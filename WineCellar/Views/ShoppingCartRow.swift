//
//  ShoppingCartRow.swift
//  WineCellar
//
//  Created by Christopher Alford on 21/9/23.
//

import SwiftUI

struct ShoppingCartRow: View {
    let item: CartItem
    @State private var quantity = 0
    @State private var isDirty = false

    let saveAction: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(item.name)
                    .font(.title2)
                Spacer()
                Text(item.year)
            }
            Text(item.wineType.description)
            Divider()
            Text("Quantity: ")
            HStack {
                Button {
                    quantity -= 1
                    isDirty = true
                } label: {
                    Image(systemName: "minus.circle")
                }
                .buttonStyle(.plain)
                TextField("quantity", value: $quantity, format: .number)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
                Button {
                    quantity += 1
                    isDirty = true
                } label: {
                    Image(systemName: "plus.circle")
                }
                .buttonStyle(.plain)
                Spacer()
                Button(action: {
                    saveAction(quantity)
                    isDirty = false
                }) {
                    Text("Update")
                }
                .buttonStyle(.bordered)
                .disabled(isDirty == false)
            }
        }
        .onAppear {
            quantity = item.quantity
        }
    }
}

//#Preview {
//    ShoppingCartRow()
//}
