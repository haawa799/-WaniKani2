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

public class KanjiInfo: Object, WaniModelConvertable {

  public typealias PersistantType = PersistanceLayer.KanjiInfo
  public typealias WaniType = WaniModel.KanjiInfo

  public dynamic var character: String = ""
  public dynamic var meaning: String?
  public dynamic var onyomi: String?
  public dynamic var kunyomi: String?
  public dynamic var nanori: String?
  public dynamic var importantReading: String?
  public dynamic var level: Int = 0
  public dynamic var percentage: String?
  public dynamic var unlockedDate: Date?
  public dynamic var userSpecific: UserSpecific?

  override public static func primaryKey() -> String? {
    return "character"
  }

  public convenience required init(model: WaniType) {
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

  public var waniModelStruct: WaniType {
    return WaniModel.KanjiInfo(realmObject: self)
  }
}

extension KanjiInfo.WaniType: PersistanceModelInstantiatible {

  public typealias PersistantType = PersistanceLayer.KanjiInfo

  public init(realmObject: PersistantType) {
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
