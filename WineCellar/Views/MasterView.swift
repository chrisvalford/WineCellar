//
//  MasterView.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct MasterView: View {
    var appState = AppState()

    var body: some View {
        NavigationStack {
            List {
                Section("New wines") {
                    ForEach(appState.newWines, id:\.self) { wine in
                        NavigationLink(wine.name, value: Route.newWine(wine))
                    }
                }
                Section("All wines") {
                    ForEach(appState.selectedWines, id:\.self) { wine in
                        NavigationLink(wine.name, value: Route.wine(wine))
                    }
                }
            }
            .navigationTitle("Wine list")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case let .wine(wine):
                    WineDetail(wine: wine)
                case let .newWine(wine):
                    NewWineDetail(wine: wine)
                case let .shoppingCart(user: user):
                    ShoppingCart(user: user)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: Route.shoppingCart(appState.user)) {
                        Image(systemName: "cart")
                    }
                }
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
