//
//  UserSpecific.swift
//  WatchKit
//
//  Created by Andriy K. on 9/11/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public struct UserSpecific: WaniKaniDataStructure {

  struct DictionaryKey {
    static let srs = "srs"
    static let srsNumeric = "srs_numeric"
    static let unlockDate = "unlocked_date"
    static let avaliableDate = "available_date"
    static let burned = "burned"
    static let burnedDate = "burned_date"
    static let meaningCorrect = "meaning_correct"
    static let meaningIncorrect = "meaning_incorrect"
    static let meaningMaxStreak = "meaning_max_streak"
    static let meaningCurrentStreak = "meaning_current_streak"
    static let readingCorrect = "reading_correct"
    static let readingIncorrect = "reading_incorrect"
    static let readingMaxStreak = "reading_max_streak"
    static let readingCurrentStreak = "reading_current_streak"
    static let meaningNote = "meaning_note"
    static let userSynonyms = "user_synonyms"
    static let readingNote = "reading_note"
  }

  // Fields
  public var srs: String?
  public var srsNumeric: Int?
  public var unlockedDate: Date?
  public var availableDate: Date?
  public var burned: Bool
  public var burnedDate: Date?
  public var meaningCorrect: Int?
  public var meaningIncorrect: Int?
  public var meaningMaxStreak: Int?
  public var meaningCurrentStreak: Int?
  public var readingCorrect: Int?
  public var readingIncorrect: Int?
  public var readingMaxStreak: Int?
  public var readingCurrentStreak: Int?
  public var meaningNote: String?
  public var userSynonyms: String?
  public var readingNote: String?

  public init(dict: [String : AnyObject]) {
    srs = (dict[DictionaryKey.srs] as? String)
    srsNumeric = (dict[DictionaryKey.srsNumeric] as? Int)
    burned = (dict[DictionaryKey.burned] as! Bool) // swiftlint:disable:this force_cast
    if let unlock = dict[DictionaryKey.unlockDate] as? Int {
      unlockedDate = Date(timeIntervalSince1970: TimeInterval(unlock))
    }
    if let avaliable = dict[DictionaryKey.avaliableDate] as? Int {
      availableDate = Date(timeIntervalSince1970: TimeInterval(avaliable))
    }
    if let burnedDateInt = dict[DictionaryKey.burnedDate] as? Int {
      burnedDate = Date(timeIntervalSince1970: TimeInterval(burnedDateInt))
    }
    meaningCorrect = (dict[DictionaryKey.meaningCorrect] as? Int)
    meaningIncorrect = (dict[DictionaryKey.meaningIncorrect] as? Int)
    meaningMaxStreak = (dict[DictionaryKey.meaningMaxStreak] as? Int)
    meaningCurrentStreak = (dict[DictionaryKey.meaningCurrentStreak] as? Int)
    readingCorrect = (dict[DictionaryKey.readingCorrect] as? Int)
    readingIncorrect = (dict[DictionaryKey.readingIncorrect] as? Int)
    readingMaxStreak = (dict[DictionaryKey.readingMaxStreak] as? Int)
    readingCurrentStreak = (dict[DictionaryKey.readingCurrentStreak] as? Int)
    meaningNote = (dict[DictionaryKey.meaningNote] as? String)
    userSynonyms = (dict[DictionaryKey.userSynonyms] as? String)
    readingNote = (dict[DictionaryKey.readingNote] as? String)
  }

}
