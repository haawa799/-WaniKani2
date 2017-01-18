//
//  LevelProgressionInfo.swift
//  Pods
//
//  Created by Andriy K. on 12/10/15.
//
//

import Foundation

public struct LevelProgressionInfo {
  
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
  public let currentLevel: Int
  
}

public extension LevelProgressionInfo {
  
  public init(dict: [String : AnyObject]) {
    
    let levelProgressionDict = dict[DictionaryKey.requestedInfo] as! [String : AnyObject]
    let userInfoDict = dict[DictionaryKey.userInfo] as! [String : AnyObject]
    
    radicalsProgress = (levelProgressionDict[DictionaryKey.radicalsProgress] as? Int)
    radicalsTotal = (levelProgressionDict[DictionaryKey.radicalsTotal] as? Int)
    kanjiProgress = (levelProgressionDict[DictionaryKey.kanjiProgress] as? Int)
    kanjiTotal = (levelProgressionDict[DictionaryKey.kanjiTotal] as? Int)
    currentLevel = userInfoDict[DictionaryKey.level] as! Int
  }
  
}
