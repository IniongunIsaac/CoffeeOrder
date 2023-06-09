//
//  CoffeeOrderE2ETests.swift
//  CoffeeOrderE2ETests
//
//  Created by Isaac Iniongun on 22/04/2023.
//

import XCTest

final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_make_sure_no_orders_message_is_displayed() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
    }
}


final class when_adding_a_new_coffee_order: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        //go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        //fill out the form
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Shaana")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Good Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("5.5")
        
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_in_list_successfully() {
        XCTAssertEqual("Shaana", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Good Coffee (Small)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$5.50", app.staticTexts["coffeePriceText"].label)
    }
    
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")) else { return }
            
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
}


final class when_deleting_an_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        //go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        //fill out the form
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Shaana")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Good Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("5.5")
        
        placeOrderButton.tap()
    }
    
    func test_should_delete_order_successfully() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")) else { return }
            
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
}


final class when_updating_an_existing_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV" : "TEST"]
        app.launch()
        
        tearDown()
        
        //go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        //fill out the form
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Shaana")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("5.5")
        
        placeOrderButton.tap()
    }
    
    func test_should_update_order_successfully() {
        
        let orderList = app.collectionViews["orderList"]
        orderList.buttons["Shaana, Coffee (Small), $5.50"].tap()
        
        app.buttons["editOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        let _ = nameTextField.waitForExistence(timeout: 2.0)
        nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        nameTextField.typeText("Shaana Iniongun")
        
        let _ = coffeeNameTextField.waitForExistence(timeout: 10.0)
        coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        coffeeNameTextField.typeText("Some")
        
        let _ = priceTextField.waitForExistence(timeout: 2.0)
        priceTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        priceTextField.typeText("404.9")
        
        placeOrderButton.tap()
        
        XCTAssertEqual("Some", app.staticTexts["coffeeNameText"].label)
    }
    
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")) else { return }
            
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
}
