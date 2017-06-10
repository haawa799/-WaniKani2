//
//  WaniKaniUITests.swift
//  WaniKaniUITests
//
//  Created by Andriy K. on 6/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import XCTest

class WaniKaniUITests: XCTestCase {

  override func setUp() {
    super.setUp()

  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func login(app: XCUIApplication) {
    let loginField = app.textFields["username or email"]
    loginField.tap()
    loginField.typeText("paukan")

    let passwordSecureTextField = app.secureTextFields["password"]
    passwordSecureTextField.tap()
    passwordSecureTextField.typeText("Googlie9")

    app.buttons["login-button"].tap()
  }

  func acceptNotifications(app: XCUIApplication) {
    app.alerts["“WaniKani” Would Like to Send You Notifications"].buttons["Allow"].tap()
  }

  func testExample() {

    //
    continueAfterFailure = true
    let app = XCUIApplication()
    app.launch()

//    acceptNotifications(app: app)
//    login(app: app)

    sleep(10)

    XCUIApplication().scrollViews.otherElements.otherElements["progressView"].swipeLeft()

    sleep(1)

    let collectionViewsQuery = app.collectionViews
    collectionViewsQuery.staticTexts["Reviews"].tap()

    sleep(4)

    app.toolbars.buttons["Strokes"].tap()

    sleep(2)
    app.toolbars.buttons["Submit"].tap()

    sleep(1)

    let app = XCUIApplication()
    app.tabBars.buttons["Search"].tap()
    app.buttons["Start"].tap()

  }

}
