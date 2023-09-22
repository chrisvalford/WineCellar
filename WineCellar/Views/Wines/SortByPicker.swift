//
//  SortByPicker.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct SortByPicker: View {
    @Binding var selectedSort: SortOrder

    var body: some View {
        Picker("",
               selection: $selectedSort
        ) {
            ForEach(SortOrder.allCases, id: \.self) { option in
                Text(option.description)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct SortByView_Previews: PreviewProvider {

    @State static var selected: SortOrder = .none

    static var previews: some View {
        SortByPicker(selectedSort: $selected)
    }
}
