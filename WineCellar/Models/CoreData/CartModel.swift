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
                foundPivot?.quantity = 1
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
                items.append(CartItem(name: cdWine?.name ?? "",
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
