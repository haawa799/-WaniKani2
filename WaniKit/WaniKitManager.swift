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
    return CriticalItemsProviderPromise.providerPromise(endpoint: endpoint)
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
    return CriticalItemsProviderPromise.providerPromise(endpoint: endpoint)
  }

  public func fetchSRS() -> Promise<SRSDistributionInfo> {
    let endpoint = WaniEndpoints.srsDistribution(apiKey: apiKey)
    return SRSProviderPromise.providerPromise(endpoint: endpoint)
  }
}
