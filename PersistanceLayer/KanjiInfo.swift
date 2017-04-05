//
//  KanjiInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class KanjiInfo: Object, WaniModelConvertable {

  typealias PersistantType = PersistanceLayer.KanjiInfo
  typealias WaniType = WaniModel.KanjiInfo

  dynamic var character: String = ""
  dynamic var meaning: String?
  dynamic var onyomi: String?
  dynamic var kunyomi: String?
  dynamic var nanori: String?
  dynamic var importantReading: String?
  dynamic var level: Int = 0
  dynamic var percentage: String?
  dynamic var unlockedDate: Date?

  dynamic var userSpecific: UserSpecific? {
    didSet {
      if userSpecific == nil {
        userSpecific = oldValue
      }
    }
  }

  var dict: [String: Any?] {
    return [
      "character": character,
      "meaning": meaning,
      "onyomi": onyomi,
      "kunyomi": kunyomi,
      "nanori": nanori,
      "importantReading": importantReading,
      "level": level,
      "percentage": percentage,
      "unlockedDate": unlockedDate
    ]
  }

  override static func primaryKey() -> String? {
    return "character"
  }

  convenience required init(model: WaniType) {
    self.init()
    self.character = model.character
    self.meaning = model.meaning
    self.onyomi = model.onyomi
    self.kunyomi = model.kunyomi
    self.nanori = model.nanori
    self.importantReading = model.importantReading
    self.level = model.level
    self.percentage = model.percentage
    self.unlockedDate = model.unlockedDate
    if let userSpecific = model.userSpecific {
      self.userSpecific = PersistanceLayer.UserSpecific(userSpecific: userSpecific)
    }
  }

  var waniModelStruct: WaniType {
    return WaniModel.KanjiInfo(realmObject: self)
  }

}

extension KanjiInfo.WaniType: PersistanceModelInstantiatible {

  typealias PersistantType = PersistanceLayer.KanjiInfo

  init(realmObject: PersistantType) {
    self.character = realmObject.character
    self.meaning = realmObject.meaning
    self.onyomi = realmObject.onyomi
    self.kunyomi = realmObject.kunyomi
    self.nanori = realmObject.nanori
    self.importantReading = realmObject.importantReading
    self.level = realmObject.level
    self.percentage = realmObject.percentage
    self.unlockedDate = realmObject.unlockedDate
    self.userSpecific = realmObject.userSpecific?.waniModelStruct
  }
}
