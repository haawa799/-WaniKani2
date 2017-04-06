//
//  WordInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class WordInfo: Object, WaniModelConvertable {

  typealias PersistantType = PersistanceLayer.WordInfo
  typealias WaniType = WaniModel.WordInfo

  dynamic var character: String = ""
  dynamic var meaning: String?
  dynamic var kana: String?
  dynamic var level: Int = 0
  dynamic var percentage: String?
  dynamic var unlockedDate: Date?
  dynamic var userSpecific: UserSpecific?

  override static func primaryKey() -> String? {
    return "character"
  }

  convenience required init(model: WaniType) {
    self.init()
    self.character = model.character
    self.meaning = model.meaning
    self.kana = model.kana
    self.level = model.level
    self.percentage = model.percentage
    self.unlockedDate = model.unlockedDate
    if let userSpecific = model.userSpecific {
      self.userSpecific = PersistanceLayer.UserSpecific(userSpecific: userSpecific)
    }
  }

  var waniModelStruct: WaniType {
    return WaniModel.WordInfo(realmObject: self)
  }
}

extension WordInfo.WaniType: PersistanceModelInstantiatible {

  typealias PersistantType = PersistanceLayer.WordInfo

  init(realmObject: PersistantType) {
    self.character = realmObject.character
    self.meaning = realmObject.meaning
    self.kana = realmObject.kana
    self.level = realmObject.level
    self.percentage = realmObject.percentage
    self.unlockedDate = realmObject.unlockedDate
    self.userSpecific = realmObject.userSpecific?.waniModelStruct
  }
}
