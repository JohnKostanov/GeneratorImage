//
//  FirstViewControllerTests.swift
//  GeneratorImageUITests
//
//  Created by Джон Костанов on 1/6/23.
//

import XCTest

final class FirstViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testTextFieldInput() {
        // Arrange
        let textField = app.textFields["TextFieldForRequest"]
        let expectedText = "Hello World"
        
        // Act
        textField.tap()
        textField.typeText(expectedText)
        
        // Assert
        XCTAssertEqual(textField.value as? String, expectedText)
    }
    
}
