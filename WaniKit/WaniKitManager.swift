//
//  WaniKitManager.swift
//  WaniKani
//
//  Created by Andriy K. on 3/17/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise
import WaniModel

public extension WaniEndpoints {

  public var promiseWithFetchAndParse: Promise<WaniParsedData> {
    return WaniPromises.newFetchPromise(url: url).then { (data, _) -> Promise<Data> in
      // Networking promise
      return Promise(value: data)
      }.then { (data) -> Promise<WaniParsedData> in
        // Parse promise
        return WaniPromises.newParsePromise(data: data)
    }
  }
}

public struct WaniKitManager {
  
  public enum Errors: Error {
    case noRecentUnlocks
    case studyQueueNotLoaded
    case levelProgressionNotLoaded
    case srsNotLoaded
    case lastLevelUpNotLoaded
    case onOfFieldsNotLoadedButCounterIncreased
  }

  fileprivate let apiKey: String

  public init(apiKey: String) {
    self.apiKey = apiKey
  }

  public func fetchUserInfo() -> Promise<UserInfo> {
    let endpoint = WaniEndpoints.userInfo(apiKey: apiKey)
    return UserInfoProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchLevelProgression() -> Promise<LevelProgressionInfo> {
    let endpoint = WaniEndpoints.levelProgression(apiKey: apiKey)
    return LevelProgressionProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchCriticalItems(percentage: Int) -> Promise<[ReviewItemInfo]> {
    let endpoint = WaniEndpoints.criticalItems(apiKey: apiKey, percentage: percentage)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchRadicalPromise(level: Int) -> Promise<[RadicalInfo]> {
    let endpoint = WaniEndpoints.radicalList(apiKey: apiKey, level: level)
    return RadicalProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchKanjiPromise(level: Int) -> Promise<[KanjiInfo]> {
    let endpoint = WaniEndpoints.kanjiList(apiKey: apiKey, level: level)
    return KanjiProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchVocabPromise(level: Int) -> Promise<[WordInfo]> {
    let endpoint = WaniEndpoints.wordList(apiKey: apiKey, level: level)
    return VocabProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchRecentUnlocks(limit: Int) -> Promise<[ReviewItemInfo]> {
    let endpoint = WaniEndpoints.recentUnlocks(apiKey: apiKey, limit: limit)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchSRS() -> Promise<SRSDistributionInfo> {
    let endpoint = WaniEndpoints.srsDistribution(apiKey: apiKey)
    return SRSProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchStudyQueue() -> Promise<StudyQueueInfo> {
    let endpoint = WaniEndpoints.studyQueue(apiKey: apiKey)
    return StudyQueueProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchLastLevelUp() -> Promise<Date> {
    let endpoint = WaniEndpoints.recentUnlocks(apiKey: apiKey, limit: 1)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint).then { (items) -> Promise<Date> in
      guard let first = items.first, let date = first.unlockedDate else { throw WaniKitManager.Errors.noRecentUnlocks }
      return Promise(value: date)
    }
  }
  
  public func fetchDashboard() -> Promise<DashboardInfo> {

    let studyQueuePromise = fetchStudyQueue()
    let levelProgressionPromise = fetchLevelProgression()
    let srsPromise = fetchSRS()
    let lastLevelUpPromise = fetchLastLevelUp()

    return Promise<(DashboardInfo)>(work: { fulfill, reject in

      // Resources
      let allPromisesCount = 4
      var counter = 0
      var date: Date?
      var studyQueue: StudyQueueInfo?
      var levelProgression: LevelProgressionInfo?
      var srs: SRSDistributionInfo?
      
      func tryToFulfillPromise() throws {
        guard counter == allPromisesCount else { return }
        guard let studyQueue = studyQueue, let levelProgression = levelProgression, let srs = srs else { throw WaniKitManager.Errors.onOfFieldsNotLoadedButCounterIncreased }
        let dashboard = DashboardInfo(levelProgressionInfo: levelProgression, studyQueueInfo: studyQueue, srs: srs, lastLevelUpDate: date)
        fulfill(dashboard)
      }
      
      // study queue promise
      studyQueuePromise.then({ (queue) in
        studyQueue = queue
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitManager.Errors.studyQueueNotLoaded) })

      // level progression promise
      levelProgressionPromise.then({ (progression) in
        levelProgression = progression
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitManager.Errors.levelProgressionNotLoaded) })

      // srs promise
      srsPromise.then({ (srsDistribution) in
        srs = srsDistribution
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitManager.Errors.srsNotLoaded) })

      // lastLevelUp promise
      lastLevelUpPromise.then({ (levelUpDate) in
        date = levelUpDate
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitManager.Errors.lastLevelUpNotLoaded) })
      
    })
  }
}
