//
//  SearchView.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct SearchView: View {
    let query: String
    var body: some View {
        Text(query)
    }
}

struct SearchView_Previews: PreviewProvider {
    static let query = "Some query"
    static var previews: some View {
        SearchView(query: query)
    }
}
