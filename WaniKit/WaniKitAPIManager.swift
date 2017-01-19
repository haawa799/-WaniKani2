//
//  WaniKitAPIManager.swift
//  WaniKit
//
//  Created by Andriy K. on 9/12/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import PSOperations
import WaniModel

public protocol WaniApiManagerDelegate: class {
  func apiKeyWasUsedBeforeItWasSet()
  func apiKeyWasSet()
}

public struct WaniKitAPIManager {

  struct WaniKitConstants {
    struct URL {
      static let baseURL = "https://www.wanikani.com/api/user/"
    }
  }

  public let operationQueue = PSOperations.OperationQueue()
  public let apiKey: String

  public init(apiKey: String) {
    self.apiKey = apiKey
  }

  var basicURL: URL {
    let string = "\(WaniKitConstants.URL.baseURL)\(apiKey)"
    return URL(string: string)!
  }
  // MARK: - Methods
  public func fetchLevelProgression(handler: @escaping (LevelProgressionInfo?, NetworkOperationResponseCode?) -> Void) {
    let levelProgressionGroupOperation = LevelProgressionGroupOperation(baseURL: basicURL) { (progressionInfo, resopnseCode) in
      handler(progressionInfo, resopnseCode)
    }
    operationQueue.addOperation(levelProgressionGroupOperation)
  }

  public func fetchUserInfo(handler: @escaping (UserInfo?, NetworkOperationResponseCode?) -> Void) {
    let userInfoGroupOperation = UserInfoGroupOperation(baseURL: basicURL) { (userInfo, resopnseCode) in
      handler(userInfo, resopnseCode)
    }
    operationQueue.addOperation(userInfoGroupOperation)
  }

  public func fetchStudyQueue(handler: @escaping (StudyQueueInfo?, NetworkOperationResponseCode?) -> Void) {
    let studyQueueGroupOperation = StudyQueueGroupOperation(baseURL: basicURL) { (studyQueue, resopnseCode) in
      handler(studyQueue, resopnseCode)
    }
    operationQueue.addOperation(studyQueueGroupOperation)
  }

  public func fetchKanjiList(level: Int, handler: @escaping ([KanjiInfo]?, NetworkOperationResponseCode?) -> Void) {
    let kanjiListGroupOperation = KanjiListGroupOperation(baseURL: basicURL, level: level) { (kanjiList, resopnseCode) in
      handler(kanjiList, resopnseCode)
    }
    operationQueue.addOperation(kanjiListGroupOperation)
  }

  public func fetchRadicalList(level: Int, handler: @escaping ([RadicalInfo]?, NetworkOperationResponseCode?) -> Void) {
    let radicalListGroupOperation = RadicalListGroupOperation(baseURL: basicURL, level: level) { (radicalList, resopnseCode) in
      handler(radicalList, resopnseCode)
    }
    operationQueue.addOperation(radicalListGroupOperation)
  }

  public func fetchWordsList(level: Int, handler: @escaping ([WordInfo]?, NetworkOperationResponseCode?) -> Void) {
    let wordListGroupOperation = WordListGroupOperation(baseURL: basicURL, level: level) { (wordsList, resopnseCode) in
      handler(wordsList, resopnseCode)
    }
    operationQueue.addOperation(wordListGroupOperation)
  }

  public func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    let dashboardInfoGroupOperation = DashboardInfoGroupOperation(baseURL: basicURL) { (dashboardInfo) in
      handler(dashboardInfo)
    }
    operationQueue.addOperation(dashboardInfoGroupOperation)
  }

  public func fetchCriticalItems(maxPercentage: Int, handler: @escaping ([ReviewItemInfo]?, NetworkOperationResponseCode?) -> Void) {
    let criticalItemsGroupOperation = CriticalItemsGroupOperation(baseURL: basicURL, maxPercentage: maxPercentage) { (items, responseCode) in
      handler(items, responseCode)
    }
    operationQueue.addOperation(criticalItemsGroupOperation)
  }

  public func fetchRecentUnlocksItems(limit: Int, handler: @escaping ([ReviewItemInfo]?, NetworkOperationResponseCode?) -> Void) {
    let recentUnlocksGroupOperation = RecentUnlocksGroupOperation(baseURL: basicURL, limit: limit) { (items, responseCode) in
      handler(items, responseCode)
    }
    operationQueue.addOperation(recentUnlocksGroupOperation)
  }

  public func fetchLastLevelUp(handler: @escaping (Date?) -> Void) {
    let lastLevelUpGroupOperation = LastLevelUpGroupOperation(baseURL: basicURL) { (date) in
      handler(date)
    }
    operationQueue.addOperation(lastLevelUpGroupOperation)
  }

  public func fetchSRSDistribution(handler: @escaping (SRSDistributionInfo?, NetworkOperationResponseCode?) -> Void) {
    let srsDistributionGroupOperation = SRSDistributionGroupOperation(baseURL: basicURL) { (srs, responseCode) in
      handler(srs, responseCode)
    }
    operationQueue.addOperation(srsDistributionGroupOperation)
  }

  public func fetchAllKanji(handler: @escaping ([Int : [KanjiInfo]]) -> Void) {
    let allKanjiGroupOperation = AllKanjiGroupOperation(baseURL: basicURL) { (kanji) in
      handler(kanji)
    }
    operationQueue.addOperation(allKanjiGroupOperation)
  }

}
