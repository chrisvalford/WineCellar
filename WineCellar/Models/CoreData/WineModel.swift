//
//  WineModel.swift
//  WineCellar
//
//  Created by Christopher Alford on 20/9/23.
//

import Foundation
import CoreData

enum ModelException: Error {
    case createFailed
    case deleteFailed
    case updateFailed
}

protocol WineModelInterface {
    func create(wine: Wine) throws
    func delete(wine: Wine) throws
    func fetch(wine: Wine) throws -> Wine?
    func update(wine: Wine) throws
    func fetch(wineType: WineType) throws -> [Wine]
}

class WineModel: WineModelInterface {

    var context: NSManagedObjectContext {
        let persistenceController = PersistenceController.shared
        return persistenceController.container.viewContext
    }

    func create(wine: Wine) throws {
        let cdWine = CDWine(context: context)
        cdWine.name = wine.name
        cdWine.year = wine.year
        cdWine.wineType = Int16(wine.wineType.rawValue)
        do {
            try context.save()
        }
        catch {
            throw ModelException.createFailed
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

    func fetch(wine: Wine) throws -> Wine? {
        return Wine(name: "", year: "", wineType: .white)
    }

    func all() throws -> [Wine] {
        return []
    }

    func fetch(wineType: WineType) throws -> [Wine] {
        var wines: [Wine] = []
        let fetchRequest: NSFetchRequest<CDWine> = CDWine.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "wineType == %@", wineType as! CVarArg)
        let objects = try context.fetch(fetchRequest)
        for object in objects {
            wines.append(Wine(name: object.name ?? "",
                              year: object.year ?? "",
                              wineType: WineType(rawValue: Int(object.wineType)) ?? .unknown))
        }
        return wines
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
}
