//
//  TCA_PracticeUITests.swift
//  TCA_PracticeUITests
//
//  Created by Neil Chan on 2025/5/14.
//

import XCTest

final class TCA_PracticeUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
//    @MainActor
//    func testLoginSuccessFlow() {
//        let usernameField = app.textFields["Username"]
//        let passwordField = app.secureTextFields["Password"]
//        let loginButton = app.buttons["Login"]
//        
//        XCTAssertTrue(usernameField.waitForExistence(timeout: 3))
//        XCTAssertTrue(passwordField.waitForExistence(timeout: 3))
//        XCTAssertTrue(loginButton.waitForExistence(timeout: 3))
//        
//        usernameField.tap()
//        usernameField.typeText("123")
//        
//        passwordField.tap()
//        passwordField.typeText("456")
//        
//        loginButton.tap()
//        
//        let postListTitle = app.staticTexts["PostListTitle"]
//        XCTAssertTrue(postListTitle.waitForExistence(timeout: 30))
//    }
    
}

