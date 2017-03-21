//
//  WaniKitTests.swift
//  WaniKitTests
//
//  Created by Andriy K. on 9/19/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import XCTest
@testable import WaniKit
import Promise
import WaniModel

class WaniKitTests: XCTestCase {

  let manager = WaniKitManager(apiKey: "c6ce4072cf1bd37b407f2c86d69137e3")
  let timeOut: TimeInterval = 2

  func testUserInfo() {
    let exp = expectation(description: "userInfo")
    manager.fetchUserInfo().then { (userInfo) in
      assert(userInfo.username == "haawa")
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testLevelProgression() {
    let exp = expectation(description: "levelProgression")
    manager.fetchLevelProgression().then { (levelProgression) in
      assert(levelProgression.userInfo.level == 22)
      assert(levelProgression.kanjiTotal! > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testCriticalItems() {
    let exp = expectation(description: "critical items")
    manager.fetchCriticalItems(percentage: 85).then { (criticalItems) in
      assert(criticalItems.count > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testRadicals() {
    let exp = expectation(description: "radicals")
    manager.fetchRadicalPromise(level: 20).then { (radicals) in
      assert(radicals.count > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testKanji() {
    let exp = expectation(description: "kanji")
    manager.fetchKanjiPromise(level: 20).then { (kanji) in
      assert(kanji.count == 32)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testVocab() {
    let exp = expectation(description: "vocab")
    manager.fetchVocabPromise(level: 20).then { (words) in
      assert(words.count > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testRecents() {
    let exp = expectation(description: "recents")
    manager.fetchRecentUnlocks(limit: 20).then { (items) in
      assert(items.count == 20)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testSrs() {
    let exp = expectation(description: "srs")
    manager.fetchSRS().then { (srs) in
      assert(srs.burned.kanji > 500)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testStudyQueue() {
    let exp = expectation(description: "studyQueue")
    manager.fetchStudyQueue().then { (studyQueue) in
      assert(studyQueue.lessonsAvaliable! > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testLastLevelUp() {
    let exp = expectation(description: "levelUp")
    manager.fetchLastLevelUp().then { (date) in
      assert(date.timeIntervalSince1970 > 0)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }

  func testDashboard() {
    let exp = expectation(description: "dashboard")
    manager.fetchDashboard().then { (dashboard) in
      assert(dashboard.levelProgressionInfo.kanjiTotal == 31)
      exp.fulfill()
      }.catch { (error) in
        debugPrint(error)
    }
    waitForExpectations(timeout: timeOut, handler: nil)
  }
}
