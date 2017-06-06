//
//  RadicalInfo.swift
//  Pods
//
//  Created by Andriy K. on 2/15/16.
//
//

import Foundation

public struct RadicalInfo {
  
  // Dictionary keys
  static let keyCharacter = "character"
  static let keyMeaning = "meaning"
  static let keyImage = "image"
  static let keyLevel = "level"
  static let keyPercentage = "percentage"
  
  static let keyUserSpecific = "user_specific"
  
  public var character: String?
  public var meaning: String?
  public var image: String?
  public var level: Int
  public var percentage: String?
  
  public var userSpecific: UserSpecific?
}

public extension RadicalInfo {
  
  public init(level: Int) {
    self.level = level
  }
  
  public init(dict: [String : AnyObject]) {
    character = dict[RadicalInfo.keyCharacter] as? String
    image = dict[RadicalInfo.keyImage] as? String
    level = (dict[RadicalInfo.keyLevel] as? Int) ?? 0
    percentage = dict[RadicalInfo.keyPercentage] as? String
    if let meaningString = dict[WordInfo.keyMeaning] as? String {
      let meanings = meaningString.components(separatedBy: ", ")
      var newMeaningstring = meanings.first!
      if meanings.count > 1 {
        newMeaningstring += ", \(meanings[1])"
      }
      meaning = newMeaningstring
    }
    
    if let userSpecificDict = dict[RadicalInfo.keyUserSpecific] as? [String : AnyObject] {
      userSpecific = UserSpecific(dict: userSpecificDict)
    }
  }
}
