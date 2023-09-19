//
//  WineCellarApp.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

@main
struct WineCellarApp: App {
//    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MasterView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
