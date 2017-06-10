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
    app.alerts ["“WaniKani” Would Like to Send You Notifications"].buttons["Allow"].tap()
  }

  func startLoading(app: XCUIApplication) {
    app.buttons["Start"].tap()
    sleep(25)
  }

  func testExample() {

    //
    continueAfterFailure = true
    let app = XCUIApplication()
    app.launch()

//    acceptNotifications(app: app)
    login(app: app)

    sleep(15)

    snapshot("Dashboard", waitForLoadingIndicator: false)
    XCUIApplication().scrollViews.otherElements.otherElements["progressView"].swipeLeft()

    sleep(1)
    snapshot("SRS", waitForLoadingIndicator: false)
    sleep(1)

    var collectionViewsQuery = app.collectionViews
    collectionViewsQuery.staticTexts["Reviews"].tap()

    sleep(5)

    XCUIApplication().toolbars.buttons["Done"].tap()
    snapshot("Review", waitForLoadingIndicator: false)

    app.toolbars.buttons["Strokes"].tap()
    sleep(2)
    snapshot("Strokes", waitForLoadingIndicator: false)

    sleep(2)
    app.toolbars.buttons["Submit"].tap()

    sleep(1)

    app.tabBars.buttons["Search"].tap()
    startLoading(app: app)

    let searchTextOrLevelNumberTextField = app.textFields["Search text or level number"]
    searchTextOrLevelNumberTextField.tap()
    searchTextOrLevelNumberTextField.typeText("a")

    sleep(10)
    collectionViewsQuery = app.collectionViews
    collectionViewsQuery.staticTexts["亅"].tap()
    snapshot("Radical", waitForLoadingIndicator: false)
    app.navigationBars["亅"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
    collectionViewsQuery.children(matching: .cell).element(boundBy: 5).staticTexts["女"].tap()
    snapshot("Kanji", waitForLoadingIndicator: false)
    app.navigationBars["女"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
    collectionViewsQuery.staticTexts["下さい"].tap()
    snapshot("Word", waitForLoadingIndicator: false)
    app.navigationBars["下さい"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()

    sleep(1)
    snapshot("Search", waitForLoadingIndicator: false)
    sleep(1)
    app.tabBars.buttons["Settings"].tap()

    collectionViewsQuery = app.collectionViews
    let cellsQuery = collectionViewsQuery.cells
    cellsQuery.otherElements.containing(.staticText, identifier:"Fast forward").otherElements["switch"].tap()
    cellsQuery.otherElements.containing(.staticText, identifier:"Ignore button").otherElements["switch"].tap()
    cellsQuery.otherElements.containing(.staticText, identifier:"Reorder script").otherElements["switch"].tap()
    cellsQuery.otherElements.containing(.staticText, identifier:"Ignore lessons in icon badge").otherElements["switch"].tap()

    sleep(1)

    snapshot("Settings", waitForLoadingIndicator: false)
  }

}
