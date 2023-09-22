//
//  ShoppingCartInfo.swift
//  WineCellar
//
//  Created by Christopher Alford on 22/9/23.
//

import SwiftUI

struct ShoppingCartInfo: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @State private var multipleCartsEnabled = false

    var body: some View {
        VStack {
            Section {
                HStack {
                    Text("Shopping Carts, how to...")
                        .font(.title)
                        .padding(.top)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 24))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
            }
            Divider()
            Spacer()
            Section {
                Text("A shopping cart can be created for a suppier or for a wish list of wines.")
                Text("If you may have many suppliers, turn on multiple, or if it's a single wish list, leave it off.")
            }
            .padding(.vertical)
            Spacer()
            Section {
                VStack {
                    Toggle("Have multiple carts", isOn: $multipleCartsEnabled)
                    Text("You can change this at any time.")
                        .font(.caption)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ShoppingCartInfo()
}
