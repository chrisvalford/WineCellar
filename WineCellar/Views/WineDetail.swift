//
//  WineDetail.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct WineDetail: View {
    let wine: Wine

    var body: some View {
        Text(wine.year)
            .font(.title)
            .navigationTitle(wine.name)
    }
}

struct WineDetail_Previews: PreviewProvider {

    static let wine = Wine(name: "Gusto plonco", year: "2023")
    static var previews: some View {
        WineDetail(wine: wine)
    }
}
