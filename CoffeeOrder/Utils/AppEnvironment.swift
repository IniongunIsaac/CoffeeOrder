//
//  AppEnvironment.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 21/04/2023.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .dev
        }
        
        if env == "TEST" {
            return .test
        }
        
        return .dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}
