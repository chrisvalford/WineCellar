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

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section {
                HStack {
                    Text("Filter wines by ...")
                        .font(.title)
                    Spacer()
                    Button(action: {
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
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var sortOrder = SortOrder.year
    static var previews: some View {
        FilterView(sortOrder: $sortOrder)
    }
}
