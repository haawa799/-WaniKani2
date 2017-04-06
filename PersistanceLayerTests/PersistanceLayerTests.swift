//
//  PersistanceLayerTests.swift
//  PersistanceLayerTests
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import XCTest
import WaniModel
@testable import PersistanceLayer

class PersistanceLayerTests: XCTestCase {
  
  var persistance: Persistance!
  
  override func setUp() {
    super.setUp()
    persistance = Persistance(setupInMemory: true, apiKey: "apiKey")
  }
  
  override func tearDown() {
    persistance.nuke()
    super.tearDown()
  }
  
  func testStudyQueue() {
    let studyQueue = WaniModel.StudyQueueInfo(stub: WaniModelStub.studyQueue(0))
    XCTAssertNil(persistance.studyQueue)
    persistance.persist(studyQueue: studyQueue)
    XCTAssertNotNil(persistance.studyQueue)
    let persistedValue = persistance.studyQueue
    XCTAssertEqual(persistedValue, studyQueue)
  }
  
  func testLevelProgression() {
    let levelProgression0 = WaniModel.LevelProgressionInfo(stub: WaniModelStub.levelProgression(0))
    let levelProgression1 = WaniModel.LevelProgressionInfo(stub: WaniModelStub.levelProgression(1))
    XCTAssertNil(persistance.levelProgression)
    // Save first
    persistance.persist(levelProgression: levelProgression0)
    XCTAssertNotNil(persistance.levelProgression)
    var persistedValue = persistance.levelProgression
    XCTAssertEqual(persistedValue, levelProgression0)
    // Save second
    persistance.persist(levelProgression: levelProgression1)
    XCTAssertNotNil(persistance.levelProgression)
    persistedValue = persistance.levelProgression
    XCTAssertEqual(persistedValue, levelProgression1)
  }
  
  func testSRS() {
    let srs = WaniModel.SRSDistributionInfo(stub: WaniModelStub.srs(0))
    XCTAssertNil(persistance.srs)
    persistance.persist(srs: srs)
    XCTAssertNotNil(persistance.srs)
    let persistedValue = persistance.srs
    XCTAssertEqual(persistedValue, srs)
  }
  
  func testCriticalItems() {
    let criticalItems0 = WaniModel.ReviewItemInfo.listFrom(stub: WaniModelStub.critical(0))
    let criticalItems1 = WaniModel.ReviewItemInfo.listFrom(stub: WaniModelStub.critical(1))
    XCTAssertNil(persistance.criticalItems)
    // Save first
    persistance.persist(criticalItems: criticalItems0)
    XCTAssert(try! persistance.reviewItemsCountEqual(1, 1, 1))
    XCTAssertNotNil(persistance.criticalItems)
    var persistedValue = persistance.criticalItems!
    XCTAssertEqual(persistedValue, criticalItems0)
    
    // Save second
    persistance.persist(criticalItems: criticalItems1)
    XCTAssert(try! persistance.reviewItemsCountEqual(2, 2, 2))
    persistedValue = persistance.criticalItems!
    XCTAssertNotEqual(persistedValue, criticalItems0)
    XCTAssertEqual(persistedValue, criticalItems1)
  }
  
  func testRecents() {
    let recents0 = WaniModel.ReviewItemInfo.listFrom(stub: WaniModelStub.recents(0))
    let recents1 = WaniModel.ReviewItemInfo.listFrom(stub: WaniModelStub.recents(1))
    XCTAssertNil(persistance.recentsItems)
    // Save first
    persistance.persist(recents: recents0)
    XCTAssert(try! persistance.reviewItemsCountEqual(1, 2, 3))
    XCTAssertNotNil(persistance.recentsItems)
    var persistedValue = persistance.recentsItems!
    XCTAssertEqual(persistedValue, recents0)
    
    // Save second
    persistance.persist(recents: recents1)
    XCTAssert(try! persistance.reviewItemsCountEqual(2, 4, 5))
    persistedValue = persistance.recentsItems!
    XCTAssertNotEqual(persistedValue, recents0)
    XCTAssertEqual(persistedValue, recents1)
    
    // Save first one more time
    persistance.persist(recents: recents1)
    XCTAssert(try! persistance.reviewItemsCountEqual(2, 4, 5))
  }
  
  func testKanjiList() {
    let level = 20
    let kanjiList = WaniModel.KanjiInfo.listFrom(stub: WaniModelStub.kanji(0))
    XCTAssert(persistance.kanjiForLevel(level: level).count == 0)
    persistance.persist(kanji: kanjiList)
    XCTAssertNotNil(persistance.kanjiForLevel(level: level))
    let persistedValue = persistance.kanjiForLevel(level: level)
    XCTAssertEqual(persistedValue, kanjiList)
  }
  
  func testRadicalsList() {
    let level = 20
    let radicalsList = WaniModel.RadicalInfo.listFrom(stub: WaniModelStub.radicals(0))
    XCTAssert(persistance.radicalsForLevel(level: level).count == 0)
    persistance.persist(radicals: radicalsList)
    XCTAssertNotNil(persistance.radicalsForLevel(level: level))
    let persistedValue = persistance.radicalsForLevel(level: level)
    XCTAssertEqual(persistedValue, radicalsList)
  }
  
  func testWordsList() {
    let level = 20
    let wordsList = WaniModel.WordInfo.listFrom(stub: WaniModelStub.words(0))
    XCTAssert(persistance.wordsForLevel(level: level).count == 0)
    persistance.persist(words: wordsList)
    XCTAssertNotNil(persistance.wordsForLevel(level: level))
    let persistedValue = persistance.wordsForLevel(level: level)
    XCTAssertEqual(persistedValue, wordsList)
  }
  
}

extension Persistance {
  
  enum Mismatch: Error {
    case radicals
    case kanji
    case word
  }
  
  // Test number of stored individual radicals, kanji and words
  func reviewItemsCountEqual(_ radicals: Int, _ kanji: Int, _ words: Int) throws -> Bool {
    let realRadicals = self.allRadicals.count
    let realKanji = self.allKanji.count
    let realWords = self.allWords.count

    let radicalsMatch = realRadicals == radicals
    let kanjiMatch = realKanji == kanji
    let wordsMatch = realWords == words
    guard radicalsMatch else { throw(Mismatch.radicals) }
    guard kanjiMatch else { throw(Mismatch.kanji) }
    guard wordsMatch else { throw(Mismatch.word) }
    return true
  }
}
