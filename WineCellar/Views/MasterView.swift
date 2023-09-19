//
//  MasterView.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct MasterView: View {
    var appState = AppState()
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
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
                case let .search(query):
                    SearchView(query: query)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: Route.shoppingCart(appState.user)) {
                        Image(systemName: "cart")
                    }
                }
            }
            .onOpenURL { url in
                let components = URLComponents(string: url.absoluteString)
                let searchQuery = components?.queryItems?.first { $0.name == "query" }?.value

                guard let query = searchQuery else {
                    return
                }
                path.append(.search(query))
            }
            /*
             HANDOFF
             .onContinueUserActivity("com.app.search") { activity in
                guard let query = activity.userInfo?["query"] as? String else {
                    return
                }
                path.append(.search(query))
            }
             */
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
