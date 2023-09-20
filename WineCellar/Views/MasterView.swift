//
//  MasterView.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct MasterView: View {
    @StateObject var appState = AppState()
    @State private var path: [Route] = []
    @State private var isShowingFilter = false

    @State var sortOrder: SortOrder = .none
    @State var query: [Int] = []

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
                        NavigationLink("\(wine.name) (\(wine.year))", value: Route.wine(wine))
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
                Button(action: {
                    isShowingFilter = true
                }, label: {
                    Image(systemName: "eyeglasses")
                })
                NavigationLink(value: Route.shoppingCart(appState.user)) {
                    Image(systemName: "cart")
                }
            }
            .sheet(isPresented: $isShowingFilter) {
                FilterView(sortOrder: $sortOrder, query: $query) {
                    query, sortOrder in
                    self.query = query
                    self.sortOrder = sortOrder
                    appState.filter(by: query, sortedBy: sortOrder)
                }
            }

            // Deeplink
            .onOpenURL { url in
                let components = URLComponents(string: url.absoluteString)
                let searchQuery = components?.queryItems?.first { $0.name == "query" }?.value

                guard let query = searchQuery else {
                    return
                }
                path.append(.search(query))
            }

            // HANDOFF
             .onContinueUserActivity("digital.marine.winecellar") { activity in
                guard let query = activity.userInfo?["query"] as? String else {
                    return
                }
                path.append(.search(query))
            }
        }
        .environmentObject(appState)
    }
}

struct Welcome_Previews: PreviewProvider {

    static var previews: some View {
        MasterView()
    }
}
