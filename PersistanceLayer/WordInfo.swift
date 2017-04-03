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

public class WordInfo: Object, WaniModelConvertable {

  public typealias PersistantType = PersistanceLayer.WordInfo
  public typealias WaniType = WaniModel.WordInfo

  public dynamic var character: String = ""
  public dynamic var meaning: String?
  public dynamic var kana: String?
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
    self.kana = model.kana
    self.level = model.level
    self.percentage = model.percentage
    self.unlockedDate = model.unlockedDate
    if let userSpecific = model.userSpecific {
      self.userSpecific = PersistanceLayer.UserSpecific(userSpecific: userSpecific)
    }
  }

  public var waniModelStruct: WaniType {
    return WaniModel.WordInfo(realmObject: self)
  }
}

extension WordInfo.WaniType: PersistanceModelInstantiatible {

  public typealias PersistantType = PersistanceLayer.WordInfo

  public init(realmObject: PersistantType) {
    self.character = realmObject.character
    self.meaning = realmObject.meaning
    self.kana = realmObject.kana
    self.level = realmObject.level
    self.percentage = realmObject.percentage
    self.unlockedDate = realmObject.unlockedDate
    self.userSpecific = realmObject.userSpecific?.waniModelStruct
  }
}
