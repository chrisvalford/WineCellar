//
//  FilterView.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedType: WineType = .white
    @State private var isWhiteSelected = false
    @State private var isRedSelected = false
    @State private var isRoseSelected = false
    @State private var isSparklingSelected = false
    @State private var isCavaSelected = false

    @Binding var sortOrder: SortOrder
    @Binding var query: [Int]
    var sheetAction: ([Int], SortOrder) -> Void

    func buildQuery() {
        var query: [Int] = []
        if isWhiteSelected == true {
            query.append(WineType.white.rawValue)
        }
        if isRedSelected == true {
            query.append(WineType.red.rawValue)
        }
        if isRoseSelected == true {
            query.append(WineType.rose.rawValue)
        }
        if isSparklingSelected == true {
            query.append(WineType.sparkling.rawValue)
        }
        if isCavaSelected == true {
            query.append(WineType.cava.rawValue)
        }
        sheetAction(query, sortOrder)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section {
                HStack {
                    Text("Filter wines by ...")
                        .font(.title)
                    Spacer()
                    Button(action: {
                        buildQuery()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 24))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
                Divider()
            }
            Section {
                Toggle(WineType.white.description, isOn: $isWhiteSelected)
                Toggle(WineType.red.description, isOn: $isRedSelected)
                Toggle(WineType.rose.description, isOn: $isRoseSelected)
                Toggle(WineType.sparkling.description, isOn: $isSparklingSelected)
                Toggle(WineType.cava.description, isOn: $isCavaSelected)
                HStack {
                    Spacer()
                    Text("Turn all off for all wines")
                        .font(.caption)
                }
                Divider()
            }
            Section {
                Text("Sort by")
                SortByPicker(selectedSort: $sortOrder)
            }
        }
        .padding(.horizontal, 8)
        .onAppear {
            isWhiteSelected = query.contains(WineType.white.rawValue)
            isRedSelected = query.contains(WineType.red.rawValue)
            isRoseSelected = query.contains(WineType.rose.rawValue)
            isSparklingSelected = query.contains(WineType.sparkling.rawValue)
            isCavaSelected = query.contains(WineType.cava.rawValue)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var sortOrder = SortOrder.year
    @State static var query: [Int] = []
    static var previews: some View {
        FilterView(sortOrder: $sortOrder, query: $query) {
            query, sortOrder in
        }
    }
}
