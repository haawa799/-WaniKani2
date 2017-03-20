//
//  RadicalInfo.swift
//  Pods
//
//  Created by Andriy K. on 2/15/16.
//
//

import Foundation

public struct RadicalInfo: WaniKaniDataStructure {

  struct DictionaryKey {
    static let character = "character"
    static let meaning = "meaning"
    static let image = "image"
    static let level = "level"
    static let userSpecific = "user_specific"
    static let percentage = "percentage"
    static let unlockedDate = "unlocked_date"
  }

  public var character: String?
  public var meaning: String?
  public var image: String?
  public var level: Int
  public var percentage: String?
  public var unlockedDate: Date?
  public var userSpecific: UserSpecific?
}

extension RadicalInfo {

  public init(dict: [String : Any]) throws {
    guard let level = dict[DictionaryKey.level] as? Int else { throw InitialisationError.mandatoryFieldsMissing }
    self.level = level

    // Optional fields
    character = dict[DictionaryKey.character] as? String
    meaning = dict[DictionaryKey.meaning] as? String
    image = dict[DictionaryKey.image] as? String
    percentage = dict[DictionaryKey.percentage] as? String
    if let unlockedDateInt = dict[DictionaryKey.unlockedDate] as? Int {
      unlockedDate = Date(timeIntervalSince1970: TimeInterval(unlockedDateInt))
    }
    if let userSpecificDict = dict[DictionaryKey.userSpecific] as? [String : AnyObject] {
      userSpecific = UserSpecific(dict: userSpecificDict)
      unlockedDate = userSpecific?.unlockedDate
    }
  }
}
