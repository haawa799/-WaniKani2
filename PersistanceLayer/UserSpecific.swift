//
//  UserSpecific.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

public class UserSpecific: Object {
  public dynamic var srs: String?
  public let srsNumeric = RealmOptional<Int>()
  public dynamic var unlockedDate: Date?
  public dynamic var availableDate: Date?
  public dynamic var burned: Bool = false
  public dynamic var burnedDate: Date?
  public let meaningCorrect = RealmOptional<Int>()
  public let meaningIncorrect = RealmOptional<Int>()
  public let meaningMaxStreak = RealmOptional<Int>()
  public let meaningCurrentStreak = RealmOptional<Int>()
  public let readingCorrect = RealmOptional<Int>()
  public let readingIncorrect = RealmOptional<Int>()
  public let readingMaxStreak = RealmOptional<Int>()
  public let readingCurrentStreak = RealmOptional<Int>()
  public dynamic var meaningNote: String?
  public dynamic var userSynonyms: String?
  public dynamic var readingNote: String?

  public convenience init(userSpecific: WaniModel.UserSpecific) {
    self.init()
    self.srs = userSpecific.srs
    self.srsNumeric.value = userSpecific.srsNumeric
    self.unlockedDate = userSpecific.unlockedDate
    self.availableDate = userSpecific.availableDate
    self.burned = userSpecific.burned
    self.burnedDate = userSpecific.burnedDate
    self.meaningCorrect.value = userSpecific.meaningCorrect
    self.meaningIncorrect.value = userSpecific.meaningIncorrect
    self.meaningMaxStreak.value = userSpecific.meaningMaxStreak
    self.meaningCurrentStreak.value = userSpecific.meaningCurrentStreak
    self.readingCorrect.value = userSpecific.readingCorrect
    self.readingIncorrect.value = userSpecific.readingIncorrect
    self.readingMaxStreak.value = userSpecific.readingMaxStreak
    self.readingCurrentStreak.value = userSpecific.readingCurrentStreak
    self.meaningNote = userSpecific.meaningNote
    self.userSynonyms = userSpecific.userSynonyms
    self.readingNote = userSpecific.readingNote
  }

  public var waniModelStruct: WaniModel.UserSpecific {
    return WaniModel.UserSpecific(realmObject: self)
  }
}

extension WaniModel.UserSpecific {

  init(realmObject: PersistanceLayer.UserSpecific) {
    self.srs = realmObject.srs
    self.srsNumeric = realmObject.srsNumeric.value
    self.unlockedDate = realmObject.unlockedDate
    self.availableDate = realmObject.availableDate
    self.burned = realmObject.burned
    self.burnedDate = realmObject.burnedDate
    self.meaningCorrect = realmObject.meaningCorrect.value
    self.meaningIncorrect = realmObject.meaningIncorrect.value
    self.meaningMaxStreak = realmObject.meaningMaxStreak.value
    self.meaningCurrentStreak = realmObject.meaningCurrentStreak.value
    self.readingCorrect = realmObject.readingCorrect.value
    self.readingIncorrect = realmObject.readingIncorrect.value
    self.readingMaxStreak = realmObject.readingMaxStreak.value
    self.readingCurrentStreak = realmObject.readingCurrentStreak.value
    self.meaningNote = realmObject.meaningNote
    self.userSynonyms = realmObject.userSynonyms
    self.readingNote = realmObject.readingNote
  }

}
