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

public class UserInfo: Object {
  public dynamic var username: String = ""
  public dynamic var level: Int = 0
  public dynamic var gravatar: String?
  public dynamic var title: String?
  public dynamic var about: String?
  public dynamic var website: String?
  public dynamic var twitter: String?
  public let topicsCount = RealmOptional<Int>()
  public let postsCount = RealmOptional<Int>()
  public dynamic var creationDate: Date?

  override public static func primaryKey() -> String? {
    return "username"
  }

  public convenience init(userInfo: WaniModel.UserInfo) {
    self.init()
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

  public var waniModelStruct: WaniModel.UserInfo {
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
