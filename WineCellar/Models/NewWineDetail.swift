//
//  NewWineDetail.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct NewWineDetail: View {
    let wine: NewWine

    var body: some View {
        Text(wine.name)
            .font(.title)
            .navigationTitle("Latest wines")
    }
}

struct NewWineDetail_Previews: PreviewProvider {
    static let wine = NewWine(name: "Drink Me!")
    static var previews: some View {
        NewWineDetail(wine: wine)
    }
}
