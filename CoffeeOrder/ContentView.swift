//
//  ContentView.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var coffeeModel: CoffeeModel
    
    private func populateOrders() async {
        do {
            try await coffeeModel.populateOrders()
        } catch {
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = coffeeModel.orders[index]
            guard let orderId = order.id else { return }
            
            Task {
                do {
                    try await coffeeModel.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if coffeeModel.orders.isEmpty {
                    Text("No orders available!").accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(coffeeModel.orders) { order in
                            NavigationLink(value: order.id) {
                                OrderCellView(order: order)
                            }
                        }.onDelete(perform: deleteOrder)
                    }
                }
            } //: VStack
            .navigationDestination(for: Int.self, destination: { orderId in
                OrderDetailView(orderId: orderId)
            })
            .task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                AddCoffeeView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add New Order")
                    }
                    .accessibilityIdentifier("addNewOrderButton")

                }
            } //:toolbar
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView().environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
