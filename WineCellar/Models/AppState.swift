//
//  AppState.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI
import CoreData


class AppState: ObservableObject {
    let persistenceController = PersistenceController.shared
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    @Published var showOnboarding = false
    @Published var selectedWines: [Wine] = []

    // Replace with a fetch
    var storedWines: [Wine] = [
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

    @Published var newWines: [NewWine] = [NewWine(name: "New Red"),
                                          NewWine(name: "New White"),
                                          NewWine(name: "New Sparkling"),
                                          NewWine(name: "New Cava")]

    @Published var user = User(id: UUID(), name: "Bob")

    init() {
        selectedWines = storedWines
    }

    func sortBy(sortOrder: SortOrder) {
        if sortOrder == .none {
            selectedWines = storedWines
        } else if sortOrder == .name {
            selectedWines = storedWines.sorted(by: { $0.name < $1.name })
        } else if sortOrder == .year {
            selectedWines = storedWines.sorted(by: { $0.year < $1.year })
        }
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
