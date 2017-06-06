//
//  KanjiInfo.swift
//  Pods
//
//  Created by Andriy K. on 12/27/15.
//
//

import Foundation

public struct UserSpecific {
  
  // Dictionary keys
  private static let keySrs = "srs"
  private static let keySrsNumeric = "srs_numeric"
  private static let keyUnlockDate = "unlocked_date"
  private static let keyAvaliableDate = "available_date"
  private static let keyBurned = "burned"
  private static let keyBurnedDate = "burned_date"
  private static let keyMeaningCorrect = "meaning_correct"
  private static let keyMeaningIncorrect = "meaning_incorrect"
  private static let keyMeaningMaxStreak = "meaning_max_streak"
  private static let keyMeaningCurrentStreak = "meaning_current_streak"
  private static let keyReadingCorrect = "reading_correct"
  private static let keyReadingIncorrect = "reading_incorrect"
  private static let keyReadingMaxStreak = "reading_max_streak"
  private static let keyReadingCurrentStreak = "reading_current_streak"
  private static let keyMeaningNote = "meaning_note"
  private static let keyUserSynonyms = "user_synonyms"
  private static let keyReadingNote = "reading_note"
  
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
  
  public init(burned: Bool) {
    self.burned = burned
  }
  
  public init(dict: [String : AnyObject]) {
    
    srs = (dict[UserSpecific.keySrs] as? String)
    srsNumeric = (dict[UserSpecific.keySrsNumeric] as? Int)
    burned = (dict[UserSpecific.keyBurned] as? Bool) ?? false
    
    if let unlock = dict[UserSpecific.keyUnlockDate] as? Int {
      unlockedDate = Date(timeIntervalSince1970: TimeInterval(unlock))
    }
    if let avaliable = dict[UserSpecific.keyAvaliableDate] as? Int {
      availableDate = Date(timeIntervalSince1970: TimeInterval(avaliable))
    }
    if let burnedDateInt = dict[UserSpecific.keyAvaliableDate] as? Int {
      burnedDate = Date(timeIntervalSince1970: TimeInterval(burnedDateInt))
    }
    
    meaningCorrect = (dict[UserSpecific.keyMeaningCorrect] as? Int)
    meaningIncorrect = (dict[UserSpecific.keyMeaningIncorrect] as? Int)
    meaningMaxStreak = (dict[UserSpecific.keyMeaningMaxStreak] as? Int)
    meaningCurrentStreak = (dict[UserSpecific.keyMeaningCurrentStreak] as? Int)
    readingCorrect = (dict[UserSpecific.keyReadingCorrect] as? Int)
    readingIncorrect = (dict[UserSpecific.keyReadingIncorrect] as? Int)
    readingMaxStreak = (dict[UserSpecific.keyReadingMaxStreak] as? Int)
    readingCurrentStreak = (dict[UserSpecific.keyReadingCurrentStreak] as? Int)
    meaningNote = (dict[UserSpecific.keyMeaningNote] as? String)
    userSynonyms = (dict[UserSpecific.keyUserSynonyms] as? String)
    readingNote = (dict[UserSpecific.keyReadingNote] as? String)
  }
  
}

public struct KanjiInfo {
  
  // Dictionary keys
  static let keyCharacter = "character"
  static let keyMeaning = "meaning"
  static let keyOnyomi = "onyomi"
  static let keyKunyomi = "kunyomi"
  static let keyNanori = "nanori"
  static let keyImportantReading = "important_reading"
  static let keyLevel = "level"
  static let keyPercentage = "percentage"
  
  static let keyUserSpecific = "user_specific"
  
  public var character: String
  public var meaning: String?
  public var onyomi: String?
  public var kunyomi: String?
  public var nanori: String?
  public var importantReading: String?
  public var level: Int
  public var percentage: String?
  public var userSpecific: UserSpecific?
  
  public var reading: String? {
    guard let importantReading = importantReading else { return nil }
    switch importantReading {
    case "kunyomi": return kunyomi
    case "onyomi": return onyomi
    case "nanori": return nanori
    default: return nil
    }
  }
}

public extension KanjiInfo {
  
  public init(character: String, level: Int) {
    self.character = character
    self.level = level
  }
  
  public init(dict: [String : AnyObject]) {
    character = (dict[KanjiInfo.keyCharacter] as? String) ?? ""
    if let meaningString = dict[WordInfo.keyMeaning] as? String {
      let meanings = meaningString.components(separatedBy: ", ")
      var newMeaningstring = meanings.first!
      if meanings.count > 1 {
        newMeaningstring += ", \(meanings[1])"
      }
      meaning = newMeaningstring
    }
    onyomi = dict[KanjiInfo.keyOnyomi] as? String
    kunyomi = dict[KanjiInfo.keyKunyomi] as? String
    nanori = dict[KanjiInfo.keyNanori] as? String
    importantReading = dict[KanjiInfo.keyImportantReading] as? String
    level = (dict[KanjiInfo.keyLevel] as? Int) ?? 0
    percentage = dict[KanjiInfo.keyPercentage] as? String
    
    if let userSpecificDict = dict[KanjiInfo.keyUserSpecific] as? [String : AnyObject] {
      userSpecific = UserSpecific(dict: userSpecificDict)
    }
  }
}
