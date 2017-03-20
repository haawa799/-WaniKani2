//
//  LevelProgressionInfo.swift
//  Pods
//
//  Created by Andriy K. on 12/10/15.
//
//

import Foundation

public struct LevelProgressionInfo: WaniKaniDataStructure {

  struct DictionaryKey {
    static let radicalsProgress = "radicals_progress"
    static let radicalsTotal = "radicals_total"
    static let kanjiProgress = "kanji_progress"
    static let kanjiTotal = "kanji_total"
    static let requestedInfo = "requested_information"
    static let userInfo = "user_information"
    static let level = "level"
  }

  public var radicalsProgress: Int?
  public var radicalsTotal: Int?
  public var kanjiProgress: Int?
  public var kanjiTotal: Int?
  public let userInfo: UserInfo

}

public extension LevelProgressionInfo {

  public init(userInfoDict: [String : Any], requestedInfoDict: [String : Any]) throws {
    self.userInfo = try UserInfo(dict: userInfoDict)
    // Optional fields
    radicalsProgress = (requestedInfoDict[DictionaryKey.radicalsProgress] as? Int)
    radicalsTotal = (requestedInfoDict[DictionaryKey.radicalsTotal] as? Int)
    kanjiProgress = (requestedInfoDict[DictionaryKey.kanjiProgress] as? Int)
    kanjiTotal = (requestedInfoDict[DictionaryKey.kanjiTotal] as? Int)
  }

}
