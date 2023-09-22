//
//  WineDetail.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct WineDetail: View {
    @EnvironmentObject var appState: AppState

    let wine: Wine

    var body: some View {
        VStack {
            Text(wine.wineType.description)
            HStack {
                Text("Produced in:")
                Text(wine.year)
            }
            Button(action: {
                appState.addToCart(wine: wine)
            }) {
                Text("Add to cart")
            }
        }
        .navigationTitle(wine.name)
    }
}

struct WineDetail_Previews: PreviewProvider {

    static let wine = Wine(name: "Gusto plonco", year: "2023", wineType: .cava)
    static var previews: some View {
        WineDetail(wine: wine)
    }
}
