//
//  String+Extensions.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 22/04/2023.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    func isLessThan(_ number: Double) -> Bool {
        if !isNumeric {
            return false
        }
        
        guard let value = Double(self) else { return false }
        
        return value < number
    }
    
    var isNotEmpty: Bool {
        !isEmpty
    }
}
