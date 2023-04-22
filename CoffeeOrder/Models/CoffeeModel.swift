//
//  CoffeeModel.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    
    let webservice: Webservice
    @Published private(set) var orders: [Order] = []
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ id: Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(orderId: id)
        orders.removeAll(where: { $0.id == deletedOrder.id })
    }
    
}
