//
//  NavigationStore.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//  See: Swift with Majid - Mastering NavigationStack in SwiftUI. Deep Linking.
//

import Foundation

protocol UrlHandler<Route> {
    associatedtype Route: Hashable
    func handle(_ url: URL, mutating: inout [Route])
}

protocol ActivityHandler<Route> {
    associatedtype Route: Hashable
    func handle(_ activity: NSUserActivity, mutating: inout [Route])
}

@MainActor final class NavigationStore<Route: Hashable>: ObservableObject {
    @Published var path: [Route] = []

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let urlHandler: any UrlHandler<Route>
    private let activityHandler: any ActivityHandler<Route>

    init(
        urlHandler: some UrlHandler<Route>,
        activityHandler: some ActivityHandler<Route>
    ) {
        self.urlHandler = urlHandler
        self.activityHandler = activityHandler
    }

    func handle(_ activity: NSUserActivity) {
        activityHandler.handle(activity, mutating: &path)
    }

    func handle(_ url: URL) {
        urlHandler.handle(url, mutating: &path)
    }
}

extension NavigationStore where Route: Codable {
    func encoded() -> Data? {
        try? encoder.encode(path)
    }

    func restore(from data: Data) {
        do {
            path = try decoder.decode([Route].self, from: data)
        } catch {
            path = []
        }
    }
}
