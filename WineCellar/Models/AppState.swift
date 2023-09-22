//
//  AppState.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var showOnboarding = false
    @Published var selectedWines: [Wine] = []

    var storedWines: [Wine] = []
    var wineModel = WineModel()

    @Published var newWines: [NewWine] = [NewWine(name: "New Red"),
                                          NewWine(name: "New White"),
                                          NewWine(name: "New Sparkling"),
                                          NewWine(name: "New Cava")]

    @Published var user = User(id: UUID(), name: "Bob")

    init() {
        do {
            storedWines = try wineModel.all()
        } catch {
            print(error.localizedDescription)
        }
        selectedWines = storedWines
    }

    func filter(by query: [Int], sortedBy: SortOrder) {
        do {
            selectedWines = try wineModel.fetch(query: query, sortBy: sortedBy)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addToCart(wine: Wine) {
        let cartModel = CartModel()
        do {
            try cartModel.create(wine: wine)
        } catch {
            print(error.localizedDescription)
        }
    }

    func cartItems() -> [CartItem] {
        let cartModel = CartModel()
        do {
            return try cartModel.all()
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    var cartCount: Int {
        let cartModel = CartModel()
        return cartModel.count
    }

    func updateCartItem(_ cartItem: CartItem, withValue: Int) {
        let cartModel = CartModel()
        do {
            try cartModel.updateCartItem(cartItem, withValue: withValue)
        } catch {
            print(error.localizedDescription)
        }
    }
}



/*
     private func addItem() {
         withAnimation {
             let newItem = Item(context: viewContext)
             newItem.timestamp = Date()

             do {
                 try viewContext.save()
             } catch {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }

     private func deleteItems(offsets: IndexSet) {
         withAnimation {
             offsets.map { items[$0] }.forEach(viewContext.delete)

             do {
                 try viewContext.save()
             } catch {
                 // Replace this implementation with code to handle the error appropriately.
                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 let nsError = error as NSError
                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
         }
     }
 }
 */
