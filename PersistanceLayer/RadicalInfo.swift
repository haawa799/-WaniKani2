//
//  RadicalInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class RadicalInfo: Object, WaniModelConvertable {

  typealias PersistantType = PersistanceLayer.RadicalInfo
  typealias WaniType = WaniModel.RadicalInfo

  dynamic var character: String?
  dynamic var meaning: String?
  dynamic var key: String = ""
  dynamic var image: String?
  dynamic var level: Int = 0
  dynamic var percentage: String?
  dynamic var unlockedDate: Date?
  dynamic var userSpecific: PersistanceLayer.UserSpecific?

  override static func primaryKey() -> String? {
    return "key"
  }

  convenience required init(model radical: WaniType) {
    self.init()
    self.character = radical.character
    self.meaning = radical.meaning
    self.image = radical.image
    self.level = radical.level
    self.percentage = radical.percentage
    self.unlockedDate = radical.unlockedDate
    self.key = character ?? image ?? ""
    if let userSpecific = radical.userSpecific {
      self.userSpecific = PersistanceLayer.UserSpecific(userSpecific: userSpecific)
    }
  }

  var waniModelStruct: WaniType {
    return WaniModel.RadicalInfo(realmObject: self)
  }

}

extension RadicalInfo.WaniType {

  init(realmObject: RadicalInfo.PersistantType) {
    self.character = realmObject.character
    self.meaning = realmObject.meaning
    self.image = realmObject.image
    self.level = realmObject.level
    self.percentage = realmObject.percentage
    self.unlockedDate = realmObject.unlockedDate
    self.userSpecific = realmObject.userSpecific?.waniModelStruct
  }

}
