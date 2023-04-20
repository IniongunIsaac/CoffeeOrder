//
//  NumberFormatter+Extensions.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
