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
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var coffeeModel: CoffeeModel
    
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
    
    private func placeOrder() async {
        let order = Order(name: name,
                          coffeeName: coffeeName,
                          total: Double(price) ?? 0,
                          size: coffeeSize)
        
        do {
            try await coffeeModel.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                    .textInputAutocapitalization(.never)
                
                Text(errors.name).visible(errors.name.isNotEmpty)
                    .font(.caption)
                    .foregroundColor(.red)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                    .textInputAutocapitalization(.never)
                
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                    .foregroundColor(.red)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                    .textInputAutocapitalization(.never)
                
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
                        Task {
                            await placeOrder()
                        }
                    }
                } label: {
                    Text("Place Order")
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()

            } //:Form
            .navigationTitle("Add Coffee")
        } //:NavigationStack
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
