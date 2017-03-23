//
//  WaniEndpoint.swift
//  WaniKani
//
//  Created by Andriy K. on 3/17/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

internal enum WaniEndpoint {

  struct Constants {
    static let baseURL = "https://www.wanikani.com/api/user"
  }

  case userInfo(apiKey: String)
  case levelProgression(apiKey: String)
  case criticalItems(apiKey: String, percentage: Int)
  case radicalList(apiKey: String, level: Int)
  case kanjiList(apiKey: String, level: Int)
  case wordList(apiKey: String, level: Int)
  case recentUnlocks(apiKey: String, limit: Int)
  case srsDistribution(apiKey: String)
  case studyQueue(apiKey: String)

  public var url: URL {
    let urlString: String
    switch self {
      case .userInfo(let apiKey): urlString = "\(Constants.baseURL)/\(apiKey)/level-progression"
      case .levelProgression(let apiKey): urlString = "\(Constants.baseURL)/\(apiKey)/level-progression"
      case .criticalItems(let apiKey, let percentage): urlString = "\(Constants.baseURL)/\(apiKey)/critical-items/\(percentage)"
      case .radicalList(let apiKey, let level): urlString = "\(Constants.baseURL)/\(apiKey)/radicals/\(level)"
      case .kanjiList(let apiKey, let level): urlString = "\(Constants.baseURL)/\(apiKey)/kanji/\(level)"
      case .wordList(let apiKey, let level): urlString = "\(Constants.baseURL)/\(apiKey)/vocabulary/\(level)"
      case .recentUnlocks(let apiKey, let limit): urlString = "\(Constants.baseURL)/\(apiKey)/recent-unlocks/\(limit)"
      case .srsDistribution(let apiKey): urlString = "\(Constants.baseURL)/\(apiKey)/srs-distribution"
      case .studyQueue(let apiKey): urlString = "\(Constants.baseURL)/\(apiKey)/study-queue"
    }
    return URL(string: urlString)!
  }
}
