//
//  AddCoffeeView.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 22/04/2023.
//

import SwiftUI

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct AddCoffeeView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .small
    @State private var errors = AddCoffeeErrors()
    
    var isValid: Bool {
        errors = AddCoffeeErrors()
        
        if name.isEmpty {
            errors.name = "Name cannot be empty!"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee name cannot be empty!"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty!"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number!"
        } else if price.isLessThan(1) {
            errors.price = "Price must be more than 0!"
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name).accessibilityIdentifier("name")
            
            Text(errors.name).visible(errors.name.isNotEmpty)
                .font(.caption)
                .foregroundColor(.red)
            
            TextField("Coffee Name", text: $coffeeName).accessibilityIdentifier("coffeeName")
            
            Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                .font(.caption)
                .foregroundColor(.red)
            
            TextField("Price", text: $price).accessibilityIdentifier("price")
            
            Text(errors.price).visible(errors.price.isNotEmpty)
                .font(.caption)
                .foregroundColor(.red)
            
            Picker("Select size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue).tag(size)
                }
            }.pickerStyle(.segmented)
            
            Button {
                if isValid {
                    
                }
            } label: {
                Text("Place Order")
            }
            .centerHorizontally()

        }
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
