//
//  CartModel.swift
//  WineCellar
//
//  Created by Christopher Alford on 20/9/23.
//
// CDWine <-> CDCartWinePivot <-> CDCart
//

import Foundation
import CoreData

class CartModel: CartModelInterface {

    var context: NSManagedObjectContext {
        let persistenceController = PersistenceController.shared
        return persistenceController.container.viewContext
    }

    /*
     * Create a shopping cart
     */
    func create() throws {

    }

    /*
     * Add a wine to the cart via a pivot which contains the quantity value.
     * The wine will already exist.
     */
    func create(wine: Wine) throws {
        // Do we have an active cart?
        var activeCart: CDCart
        do {
            if let cart = try fetch(isActive: true) {
                activeCart = cart
            } else {
                activeCart = CDCart(context: context)
                activeCart.isActive = true
            }

            // get the CDWine
            let wineModel = WineModel()
            guard let wine: CDWine = try wineModel.fetch(wine: wine) else {
                return
            }
            // Is there a pivot already for this wine?
            var foundPivot: CDCartWinePivot?
            if let pivots = activeCart.toPivots as? Set<CDCartWinePivot> {
                for pivot in pivots {
                    if pivot.toWine === wine {
                        foundPivot = pivot
                    }
                }
            }
            if foundPivot != nil {
                foundPivot?.quantity += 1
            } else {
                foundPivot = CDCartWinePivot(context: context)
                foundPivot?.identifier = UUID()
                foundPivot?.quantity = 1
                foundPivot?.created = Date()
                // Relations
                foundPivot?.toCart = activeCart
                foundPivot?.toWine = wine
                activeCart.toPivots?.adding(foundPivot!)
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete(wine: Wine) throws {
        do {
            guard let foundWine: CDWine = try fetch(wine: wine) else {
                return
            }
            context.delete(foundWine)
        } catch {
            throw ModelException.deleteFailed
        }
    }

    var count: Int {
        var count = 0
        do {
            if let cart = try fetch(isActive: true) {
                count = cart.toPivots?.count ?? 0
            }
        } catch {
            print(error.localizedDescription)
        }
        return count
    }

    var cartCount: Int {
        var cartCount = 0
        do {
            let fetchRequest: NSFetchRequest<CDCart> = CDCart.fetchRequest()
            cartCount = try context.count(for: fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return cartCount
    }

    func all() throws -> [CartItem] {
        var items: [CartItem] = []
        // Do we have an active cart?
        var activeCart: CDCart
        do {
            if let cart = try fetch(isActive: true) {
                activeCart = cart
            } else  {
                return []
            }
        }
        if let pivots = activeCart.toPivots as? Set<CDCartWinePivot> {
            for pivot in pivots {
                let cdWine = pivot.toWine
                items.append(CartItem(identifier: pivot.identifier!,
                                      name: cdWine?.name ?? "",
                                      year: cdWine?.year ?? "",
                                      wineType: WineType(rawValue: Int(cdWine!.wineType)) ?? .unknown,
                                      quantity: Int(pivot.quantity)))
            }
        }
        return items
    }

    func update(wine: Wine) throws {
        do {
            guard let foundWine: CDWine = try fetch(wine: wine) else {
                return
            }
            foundWine.name = wine.name
            foundWine.year = wine.year
            foundWine.wineType = Int16(wine.wineType.rawValue)
        } catch {
            throw ModelException.updateFailed
        }
    }

    func updateCartItem(_ cartItem: CartItem, withValue: Int) throws {
        // Do we have an active cart?
        var activeCart: CDCart
        do {
            if let cart = try fetch(isActive: true) {
                activeCart = cart
            } else {
                throw ModelException.noActiveCart
            }
            // Is there a pivot?
            var foundPivot: CDCartWinePivot?
            if let pivots = activeCart.toPivots as? Set<CDCartWinePivot> {
                for pivot in pivots {
                    if pivot.identifier == cartItem.id {
                        foundPivot = pivot
                        break
                    }
                }
            }
            if foundPivot != nil {
                // If the new value is 0, delete this pivot
                if withValue == 0 {
                    context.delete(foundPivot!)
                }
                // Otherwise
                foundPivot?.quantity = Int16(withValue)
                if foundPivot?.quantity ?? -1 < 0 {
                    foundPivot?.quantity = 0
                }
            } else {
                throw ModelException.updateFailed
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fetch(wine: Wine) throws -> CDWine? {
        let fetchRequest: NSFetchRequest<CDWine> = CDWine.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", wine.name)
        let objects = try context.fetch(fetchRequest)
        return objects.first
    }

    private func fetch(isActive: Bool) throws -> CDCart? {
        let fetchRequest: NSFetchRequest<CDCart> = CDCart.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "isActive == %@", NSNumber(value: true)) //  isActive ? "YES" : "NO")
        let objects = try context.fetch(fetchRequest)
        return objects.first
    }

}
