//
//  ImageWithBadge.swift
//  WineCellar
//
//  Created by Christopher Alford on 21/9/23.
//

import SwiftUI

/*
 * Display a badge if the value > 0
 * Currently SwiftUI's .badge view modifier
 * is only available for lists and tabs.
 */
struct ImageWithBadge: View {

    var value: Int = 0
    var image: Image = Image(systemName: "cart")

    var body: some View {
        ZStack {
            image
            if value > 0 {
                Text(value < 10 ? "\(value)" : "9+")
                    .font(.caption)
                    .background(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 19, height: 19)
                    )
                    .offset(x: 8, y: -10)
            }
        }
    }
}

#Preview {
    ImageWithBadge()
}
