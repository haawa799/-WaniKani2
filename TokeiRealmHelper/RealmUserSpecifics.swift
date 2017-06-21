//
//  RealmUserSpecifics.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/1/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

public class RealmUserSpecific: Object {
  @objc public dynamic var srs: String?
  public let srsNumeric = RealmOptional<Int>()
  @objc public dynamic var unlockedDate: Date?
  @objc public dynamic var availableDate: Date?
  @objc public dynamic var burned: Bool = false
  @objc public dynamic var burnedDate: Date?
  public let meaningCorrect = RealmOptional<Int>()
  public let meaningIncorrect = RealmOptional<Int>()
  public let meaningMaxStreak = RealmOptional<Int>()
  public let meaningCurrentStreak = RealmOptional<Int>()
  public let readingCorrect = RealmOptional<Int>()
  public let readingIncorrect = RealmOptional<Int>()
  public let readingMaxStreak = RealmOptional<Int>()
  public let readingCurrentStreak = RealmOptional<Int>()
  @objc public dynamic var meaningNote: String?
  @objc public dynamic var userSynonyms: String?
  @objc public dynamic var readingNote: String?

  var userSpecific: UserSpecific {
    var specific = UserSpecific(burned: burned)
    specific.srs = srs
    specific.srsNumeric = srsNumeric.value
    specific.unlockedDate = unlockedDate
    specific.availableDate = availableDate
    specific.burnedDate = burnedDate
    specific.meaningCorrect = meaningCorrect.value
    specific.meaningIncorrect = meaningCorrect.value
    specific.meaningMaxStreak = meaningMaxStreak.value
    specific.meaningCurrentStreak = meaningCurrentStreak.value
    specific.readingCorrect = readingCorrect.value
    specific.readingIncorrect = readingIncorrect.value
    specific.readingMaxStreak = readingMaxStreak.value
    specific.readingCurrentStreak = readingCurrentStreak.value
    specific.meaningNote = meaningNote
    specific.userSynonyms = userSynonyms
    specific.readingNote = readingNote
    return specific
  }
}

extension RealmUserSpecific {

  func update(userSpecificInfo: UserSpecific?) {
    guard let userSpecificInfo = userSpecificInfo else { return }
    srs = userSpecificInfo.srs
    srsNumeric.value = userSpecificInfo.srsNumeric
    unlockedDate = userSpecificInfo.unlockedDate
    availableDate = userSpecificInfo.availableDate
    burned = userSpecificInfo.burned
    burnedDate = userSpecificInfo.burnedDate
    meaningCorrect.value = userSpecificInfo.meaningCorrect
    meaningIncorrect.value = userSpecificInfo.meaningCorrect
    meaningMaxStreak.value = userSpecificInfo.meaningMaxStreak
    meaningCurrentStreak.value = userSpecificInfo.meaningCurrentStreak
    readingCorrect.value = userSpecificInfo.readingCorrect
    readingIncorrect.value = userSpecificInfo.readingIncorrect
    readingMaxStreak.value = userSpecificInfo.readingMaxStreak
    readingCurrentStreak.value = userSpecificInfo.readingCurrentStreak
    meaningNote = userSpecificInfo.meaningNote
    userSynonyms = userSpecificInfo.userSynonyms
    readingNote = userSpecificInfo.readingNote
  }

}
