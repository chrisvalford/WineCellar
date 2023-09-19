//
//  WineCellerNewWine.swift
//  WineCellerNewWine
//
//  Created by Christopher Alford on 19/9/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), wine: NewWine(name: "Plonco fenominal"))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), wine: NewWine(name: "Plonco fenominal"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), wine: NewWine(name: "Plonco fenominal"))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let wine: NewWine
}

struct WineCellerNewWineEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.wine.name)
    }
}

struct WineCellerNewWine: Widget {
    let kind: String = "WineCellerNewWine"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WineCellerNewWineEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WineCellerNewWine_Previews: PreviewProvider {
    static var previews: some View {
        WineCellerNewWineEntryView(entry: SimpleEntry(date: Date(), wine: NewWine(name: "Plonco fenominal")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
