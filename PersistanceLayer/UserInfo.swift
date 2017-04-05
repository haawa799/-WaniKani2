//
//  UserInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class UserInfo: Object {
  dynamic var username: String = ""
  dynamic var level: Int = 0
  dynamic var gravatar: String?
  dynamic var title: String?
  dynamic var about: String?
  dynamic var website: String?
  dynamic var twitter: String?
  let topicsCount = RealmOptional<Int>()
  let postsCount = RealmOptional<Int>()
  dynamic var creationDate: Date?
  dynamic var userId: String = ""

  override static func primaryKey() -> String? {
    return "userId"
  }

  convenience init(userInfo: WaniModel.UserInfo, userId: String) {
    self.init()
    self.userId = userId
    self.username = userInfo.username
    self.level = userInfo.level
    self.gravatar = userInfo.gravatar
    self.title = userInfo.title
    self.about = userInfo.about
    self.website = userInfo.website
    self.twitter = userInfo.twitter
    self.topicsCount.value = userInfo.topicsCount
    self.postsCount.value = userInfo.postsCount
    self.creationDate = userInfo.creationDate
  }

  var waniModelStruct: WaniModel.UserInfo {
    return WaniModel.UserInfo(realmObject: self)
  }

}

extension WaniModel.UserInfo {

  init(realmObject: PersistanceLayer.UserInfo) {
    self.username = realmObject.username
    self.level = realmObject.level
    self.gravatar = realmObject.gravatar
    self.title = realmObject.title
    self.about = realmObject.about
    self.website = realmObject.website
    self.twitter = realmObject.twitter
    self.topicsCount = realmObject.topicsCount.value
    self.postsCount = realmObject.postsCount.value
    self.creationDate = realmObject.creationDate
  }

}
