//
//  LevelProgressionInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 4/5/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class LevelProgressionInfo: Object {

  var radicalsProgress = RealmOptional<Int>()
  var radicalsTotal = RealmOptional<Int>()
  var kanjiProgress = RealmOptional<Int>()
  var kanjiTotal = RealmOptional<Int>()
  dynamic var userId: String = ""
  dynamic var userInfo: UserInfo!

  convenience init(levelProgression: WaniModel.LevelProgressionInfo, realm: Realm, userId: String) {
    self.init()
    self.userId = userId
    self.radicalsProgress.value = levelProgression.radicalsProgress
    self.radicalsTotal.value = levelProgression.radicalsTotal
    self.kanjiProgress.value = levelProgression.kanjiProgress
    self.kanjiTotal.value = levelProgression.kanjiTotal
    if let oldUserInfo = realm.object(ofType: UserInfo.self, forPrimaryKey: userId) {
      realm.delete(oldUserInfo)
    }
    self.userInfo = UserInfo(userInfo: levelProgression.userInfo, userId: userId)
  }

  var waniModelStruct: WaniModel.LevelProgressionInfo {
    return WaniModel.LevelProgressionInfo(realmObject: self)
  }

  override static func primaryKey() -> String? {
    return "userId"
  }
}

extension WaniModel.LevelProgressionInfo {

  init(realmObject: PersistanceLayer.LevelProgressionInfo) {
    self.radicalsProgress = realmObject.radicalsProgress.value
    self.radicalsTotal = realmObject.radicalsTotal.value
    self.kanjiProgress = realmObject.kanjiProgress.value
    self.kanjiTotal = realmObject.kanjiTotal.value
    self.userInfo = realmObject.userInfo.waniModelStruct
  }
}
