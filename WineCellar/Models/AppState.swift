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
    @Published var selectedWines: [Wine] = [
        Wine(name: "Vino Juan de Jaunes", year: "2021"),
        Wine(name: "Vino Viña Albali", year: "2021"),
        Wine(name: "Vino Hécula", year: "2021"),
        Wine(name: "Tinto Compta Ovelles", year: "2021"),
        Wine(name: "Techno Hu-Hu", year: "2021"),
        Wine(name: "Vino Terra Càlida", year: "2021"),
        Wine(name: "Vino Elefant Blanc", year: "2021"),
        Wine(name: "Vino Pata Negra", year: "2021"),
        Wine(name: "Vino Protos", year: "2021"),
        Wine(name: "Competa Ovelles", year: "2021"),
        Wine(name: "Faustino Rivero", year: "2021"),
        Wine(name: "Vino Pazo", year: "2021"),
        Wine(name: "Vino Jardins", year: "2021"),
        Wine(name: "Vino Marina Alta", year: "2021"),
        Wine(name: "Cava Anna de Cordorniu", year: "2021"),
        Wine(name: "Champagne Moét Chandon", year: "2021"),
        Wine(name: "Cava brut reserva Alisina & Sarda", year: "2021"),
        Wine(name: "Cava Jume Serra", year: "2021")]

    @Published var newWines: [NewWine] = [NewWine(name: "New Red"),
                                          NewWine(name: "New White"),
                                          NewWine(name: "New Sparkling"),
                                          NewWine(name: "New Cava")]

    @Published var user = User(id: UUID(), name: "Bob")

    init() {
        // Have we any wines?

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