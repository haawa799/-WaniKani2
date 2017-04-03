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

public class RadicalInfo: Object, WaniModelConvertable {

  public typealias PersistantType = PersistanceLayer.RadicalInfo
  public typealias WaniType = WaniModel.RadicalInfo

  public dynamic var character: String?
  public dynamic var meaning: String?
  public dynamic var key: String = ""
  public dynamic var image: String?
  public dynamic var level: Int = 0
  public dynamic var percentage: String?
  public dynamic var unlockedDate: Date?
  public dynamic var userSpecific: PersistanceLayer.UserSpecific?

  override public static func primaryKey() -> String? {
    return "key"
  }

  public convenience required init(model radical: WaniType) {
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

  public var waniModelStruct: WaniType {
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
