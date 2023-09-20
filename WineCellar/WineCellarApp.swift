//
//  WineCellarApp.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

@main
struct WineCellarApp: App {
    init() {
        let model = WineModel()
        model.populate()
    }

    var body: some Scene {
        WindowGroup {
            MasterView()
        }
    }
}
