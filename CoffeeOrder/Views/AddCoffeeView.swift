//
//  AddCoffeeView.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 22/04/2023.
//

import SwiftUI

struct AddCoffeeView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .small
    
    var body: some View {
        Form {
            TextField("Name", text: $name).accessibilityIdentifier("name")
            
            TextField("Coffee Name", text: $coffeeName).accessibilityIdentifier("coffeeName")
            
            TextField("Price", text: $price).accessibilityIdentifier("price")
            
            Picker("Select size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue).tag(size)
                }
            }.pickerStyle(.segmented)
            
            Button {
                
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
