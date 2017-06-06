//
//  WordlInfo.swift
//  Pods
//
//  Created by Andriy K. on 2/17/16.
//
//

import Foundation

public struct WordInfo {
  
  // Dictionary keys
  static let keyCharacter = "character"
  static let keyKana = "kana"
  static let keyMeaning = "meaning"
  static let keyLevel = "level"
  static let keyPercentage = "percentage"
  
  static let keyUserSpecific = "user_specific"
  
  public var character: String
  public var kana: String?
  public var meaning: String?
  public var level: Int
  public var percentage: String?
  
  public var userSpecific: UserSpecific?
}

public extension WordInfo {
  
  public init(character: String, level: Int) {
    self.character = character
    self.level = level
  }
  
  public init(dict: [String : AnyObject]) {
    character = (dict[WordInfo.keyCharacter] as? String) ?? ""
    if let meaningString = dict[WordInfo.keyMeaning] as? String {
      let meanings = meaningString.components(separatedBy: ", ")
      var newMeaningstring = meanings.first!
      if meanings.count > 1 {
        newMeaningstring += ", \(meanings[1])"
      }
      meaning = newMeaningstring
    }
    kana = dict[WordInfo.keyKana] as? String
    level = (dict[WordInfo.keyLevel] as? Int) ?? 0
    percentage = dict[WordInfo.keyPercentage] as? String
    
    if let userSpecificDict = dict[WordInfo.keyUserSpecific] as? [String : AnyObject] {
      userSpecific = UserSpecific(dict: userSpecificDict)
    }
  }
}
