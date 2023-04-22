//
//  View+Extensions.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 22/04/2023.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
