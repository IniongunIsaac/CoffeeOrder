//
//  ContentView.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var coffeeModel: CoffeeModel
    
    private func populateOrders() async {
        do {
            try await coffeeModel.populateOrders()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        if coffeeModel.orders.isEmpty {
            Text("No orders available!").accessibilityIdentifier("noOrdersText")
        } else {
            List(coffeeModel.orders) { order in
                OrderCellView(order: order)
            }.task {
                await populateOrders()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
