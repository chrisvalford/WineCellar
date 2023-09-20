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
    @Published var cartItems: [Wine] = []

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
//        if query.isEmpty {
//            results = storedWines
//        } else {
//            results = storedWines.filter({
//                query.contains($0.wineType.rawValue)
//            })
//        }
//        if sortedBy == .none {
//            selectedWines = results
//        } else if sortedBy == .name {
//            selectedWines = results.sorted(by: { $0.name < $1.name })
//        } else if sortedBy == .year {
//            selectedWines = results.sorted(by: { $0.year < $1.year })
//        }
    }
}



/*
 import CoreData

 struct ContentView: View {
     @Environment(\.managedObjectContext) private var viewContext

     @FetchRequest(
         sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
         animation: .default)
     private var items: FetchedResults<Item>

     var body: some View {
         NavigationView {
             List {
                 ForEach(items) { item in
                     NavigationLink {
                         Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                     } label: {
                         Text(item.timestamp!, formatter: itemFormatter)
                     }
                 }
                 .onDelete(perform: deleteItems)
             }
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     EditButton()
                 }
                 ToolbarItem {
                     Button(action: addItem) {
                         Label("Add Item", systemImage: "plus")
                     }
                 }
             }
             Text("Select an item")
         }
     }

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

 private let itemFormatter: DateFormatter = {
     let formatter = DateFormatter()
     formatter.dateStyle = .short
     formatter.timeStyle = .medium
     return formatter
 }()

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
     }
 }

 */
