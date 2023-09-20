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
    func all() throws -> [Wine]
    func update(wine: Wine) throws
    func fetch(query: [Int], sortBy: SortOrder) throws -> [Wine]
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
        var wines: [Wine] = []
        let fetchRequest: NSFetchRequest<CDWine> = CDWine.fetchRequest()
        let objects = try context.fetch(fetchRequest)
        for object in objects {
            wines.append(Wine(name: object.name ?? "",
                              year: object.year ?? "",
                              wineType: WineType(rawValue: Int(object.wineType)) ?? .unknown))
        }
        return wines
    }

    func fetch(query: [Int], sortBy: SortOrder = .none) throws -> [Wine] {
        var wines: [Wine] = []
        let fetchRequest: NSFetchRequest<CDWine> = CDWine.fetchRequest()
        if !query.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "%@ contains wineType", query)
        }
        if sortBy != .none {
            let sort = NSSortDescriptor(key: sortBy.description.lowercased(), ascending: true)
            fetchRequest.sortDescriptors = [sort]
        }
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

    private func haveData() throws -> Bool {
        let fetchRequest: NSFetchRequest<CDWine> = CDWine.fetchRequest()
        fetchRequest.fetchLimit = 1
        let objects = try context.fetch(fetchRequest)
        return objects.count > 0 ? true : false
    }

    func populate() {
        do {
            if try haveData() {
                return
            }
        } catch {
            print(error.localizedDescription)
        }
        let wines: [Wine] = [
            Wine(name: "Vino Juan de Jaunes", year: "2021", wineType: .red),
            Wine(name: "Vino Viña Albali", year: "2022", wineType: .red),
            Wine(name: "Vino Hécula", year: "2020", wineType: .red),
            Wine(name: "Tinto Compta Ovelles", year: "2021", wineType: .red),
            Wine(name: "Techno Hu-Hu", year: "2022", wineType: .red),
            Wine(name: "Vino Terra Càlida", year: "2023", wineType: .red),
            Wine(name: "Vino Elefant Blanc", year: "2020", wineType: .white),
            Wine(name: "Vino Pata Negra", year: "2021", wineType: .red),
            Wine(name: "Vino Protos", year: "2021", wineType: .red),
            Wine(name: "Competa Ovelles", year: "2022", wineType: .white),
            Wine(name: "Faustino Rivero", year: "2022", wineType: .red),
            Wine(name: "Vino Pazo", year: "2023", wineType: .red),
            Wine(name: "Vino Jardins", year: "2015", wineType: .white),
            Wine(name: "Vino Marina Alta", year: "2018", wineType: .red),
            Wine(name: "Cava Anna de Cordorniu", year: "2020", wineType: .cava),
            Wine(name: "Champagne Moét Chandon", year: "2019", wineType: .cava),
            Wine(name: "Cava brut reserva Alisina & Sarda", year: "2019", wineType: .cava),
            Wine(name: "Cava Jume Serra", year: "2020", wineType: .cava)]
        for wine in wines {
            do {
                try create(wine: wine)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
