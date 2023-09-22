//
//  WineTypePicker.swift
//  WineCellar
//
//  Created by Christopher Alford on 19/9/23.
//

import SwiftUI

struct WineTypePicker: View {
    @Binding var selectedType: WineType

    var body: some View {
        Picker("",
               selection: $selectedType
        ) {
            ForEach(WineType.allCases, id: \.self) { option in
                Text(option.description)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct WineTypePicker_Previews: PreviewProvider {

    @State static var selected: WineType = .white

    static var previews: some View {
        WineTypePicker(selectedType: $selected)
    }
}

