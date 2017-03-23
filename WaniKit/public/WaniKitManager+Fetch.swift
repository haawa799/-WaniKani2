//
//  WaniKitManager+Fetch.swift
//  WaniKani
//
//  Created by Andriy K. on 3/23/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise
import WaniModel

public extension WaniKitManager {

  public func fetchUserInfo() -> Promise<UserInfo> {
    let endpoint = WaniEndpoint.userInfo(apiKey: apiKey)
    return UserInfoProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchLevelProgression() -> Promise<LevelProgressionInfo> {
    let endpoint = WaniEndpoint.levelProgression(apiKey: apiKey)
    return LevelProgressionProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchCriticalItems(percentage: Int) -> Promise<[ReviewItemInfo]> {
    let endpoint = WaniEndpoint.criticalItems(apiKey: apiKey, percentage: percentage)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchRadicalPromise(level: Int) -> Promise<[RadicalInfo]> {
    let endpoint = WaniEndpoint.radicalList(apiKey: apiKey, level: level)
    return RadicalProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchKanjiPromise(level: Int) -> Promise<[KanjiInfo]> {
    let endpoint = WaniEndpoint.kanjiList(apiKey: apiKey, level: level)
    return KanjiProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchVocabPromise(level: Int) -> Promise<[WordInfo]> {
    let endpoint = WaniEndpoint.wordList(apiKey: apiKey, level: level)
    return VocabProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchRecentUnlocks(limit: Int) -> Promise<[ReviewItemInfo]> {
    let endpoint = WaniEndpoint.recentUnlocks(apiKey: apiKey, limit: limit)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchSRS() -> Promise<SRSDistributionInfo> {
    let endpoint = WaniEndpoint.srsDistribution(apiKey: apiKey)
    return SRSProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchStudyQueue() -> Promise<StudyQueueInfo> {
    let endpoint = WaniEndpoint.studyQueue(apiKey: apiKey)
    return StudyQueueProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchLastLevelUp() -> Promise<Date> {
    let endpoint = WaniEndpoint.recentUnlocks(apiKey: apiKey, limit: 1)
    return ItemsProviderPromise.providerPromise(endpoint: endpoint).then { (items) -> Promise<Date> in
      guard let first = items.first, let date = first.unlockedDate else { throw WaniKitError.noRecentUnlocks }
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
        guard let studyQueue = studyQueue, let levelProgression = levelProgression, let srs = srs else { throw WaniKitError.onOfFieldsNotLoadedButCounterIncreased }
        let dashboard = DashboardInfo(levelProgressionInfo: levelProgression, studyQueueInfo: studyQueue, srs: srs, lastLevelUpDate: date)
        fulfill(dashboard)
      }

      // study queue promise
      studyQueuePromise.then({ (queue) in
        studyQueue = queue
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitError.studyQueueNotLoaded) })

      // level progression promise
      levelProgressionPromise.then({ (progression) in
        levelProgression = progression
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitError.levelProgressionNotLoaded) })

      // srs promise
      srsPromise.then({ (srsDistribution) in
        srs = srsDistribution
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitError.srsNotLoaded) })

      // lastLevelUp promise
      lastLevelUpPromise.then({ (levelUpDate) in
        date = levelUpDate
        counter += 1
        try tryToFulfillPromise()
      }).catch({ _ in reject(WaniKitError.lastLevelUpNotLoaded) })

    })
  }
}
