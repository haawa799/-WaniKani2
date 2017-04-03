//
//  Persistance.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import WaniModel

//
public class Persistance {

  let queue = DispatchQueue(label: "Realm Queue")

  let realm: Realm = {
    let config = Realm.Configuration(
      schemaVersion: 3,
      migrationBlock: { _, _ in
    })
    Realm.Configuration.defaultConfiguration = config
    return try! Realm() // swiftlint:disable:this force_try
  }()

  var user: User!

  public init() {
    guard let fetchedUser = realm.objects(User.self).first else {
      // User not created, create new user
      try? realm.write {
        user = User()
        realm.add(user)
      }
      return
    }
    user = fetchedUser
  }

  public func persist(userInfo: WaniModel.UserInfo) {
    let updated = UserInfo(userInfo: userInfo)
    try? realm.write {
      if let old = user.userInfo { realm.delete(old) }
      user.userInfo = updated
    }
  }

  public func persist(studyQueue: WaniModel.StudyQueueInfo) {
    let updated = StudyQueueInfo(userInfo: studyQueue)
    try? realm.write {
      if let old = user.studyQueue { realm.delete(old) }
      user.studyQueue = updated
    }
  }

  public func persist(srs: WaniModel.SRSDistributionInfo) {
    let updated = SRSDistributionInfo(srsDistribution: srs)
    try? realm.write {
      if let old = user.srs {
        // Delete old
        old.willBeDeleted(realm: realm)
        realm.delete(old)
      }
      user.srs = updated
    }
  }
}
