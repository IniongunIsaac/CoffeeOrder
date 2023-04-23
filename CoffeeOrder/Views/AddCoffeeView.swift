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
    
    var order: Order? = nil
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
    
    private func placeOrder(_ order: Order) async {
        do {
            try await coffeeModel.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func updateOrder(_ order: Order) async {
        do {
            try await coffeeModel.updateOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func saveOrUpdateOrder() async {
        if let order {
            var editOrder = order
            editOrder.name = name
            editOrder.coffeeName = coffeeName
            editOrder.total = Double(price) ?? 0
            editOrder.size = coffeeSize
            await updateOrder(editOrder)
        } else {
            let order = Order(name: name,
                              coffeeName: coffeeName,
                              total: Double(price) ?? 0,
                              size: coffeeSize)
            await placeOrder(order)
        }
    }
    
    private func populateExistingOrder() {
        guard let order else { return }
        name = order.name
        coffeeName = order.coffeeName
        price = String(order.total)
        coffeeSize = order.size
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
                            await saveOrUpdateOrder()
                        }
                    }
                } label: {
                    Text("\(order == nil ? "Place" : "Update") Order")
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()

            } //:Form
            .navigationTitle("\(order == nil ? "Add" : "Update") Order")
            .onAppear {
                populateExistingOrder()
            }
        } //:NavigationStack
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
