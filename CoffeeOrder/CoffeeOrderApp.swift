//
//  CoffeeOrderApp.swift
//  CoffeeOrder
//
//  Created by Isaac Iniongun on 20/04/2023.
//

import SwiftUI

@main
struct CoffeeOrderApp: App {
    
    @StateObject private var coffeeModel: CoffeeModel
    
    init() {
        let webservice = Webservice()
        _coffeeModel = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(coffeeModel)
        }
    }
}
