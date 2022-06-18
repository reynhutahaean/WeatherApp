//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Reynaldo Cristinus Hutahaean on 16/06/22.
//

import XCTest

class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddCity() {
        
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["Weather"].buttons["Add"]
        let longitudeField = app.alerts["Add City"].scrollViews.otherElements.collectionViews.textFields["Longitude"]
        let latitudeField = app.alerts["Add City"].scrollViews.otherElements.collectionViews.textFields["Latitude"]
        let addBtn = app.alerts["Add City"].scrollViews.otherElements.buttons["Add"]
        
        addButton.tap()
        longitudeField.tap()
        longitudeField.typeText("\(Double("-99.07") ?? 0.0)")
        
        latitudeField.tap()
        latitudeField.typeText("\(Double("30.84") ?? 0.0)")
        
        addBtn.tap()
        
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.tap()
        table.swipeUp()
                
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
