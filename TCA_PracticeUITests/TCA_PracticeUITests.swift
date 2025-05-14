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

    @MainActor
    func testLoginSuccessFlow() {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]

        usernameField.tap()
        usernameField.typeText("123")

        passwordField.tap()
        passwordField.typeText("password")

        loginButton.tap()

        let resultText = app.staticTexts["Login Success"]
        XCTAssertTrue(resultText.waitForExistence(timeout: 3))
    }
}

