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

public class Persistance {

  static let schemaVersion: UInt64 = 15
  let queue = DispatchQueue(label: "Realm Queue")
  let realm: Realm!
  var user: User!

  public init(setupInMemory: Bool = false, apiKey: String) {

    // Setup Realm
    let inMemoryIdentifier = setupInMemory ? "inMemoryIdentifier" : nil
    let config = Realm.Configuration(
      inMemoryIdentifier: inMemoryIdentifier,
      schemaVersion: Persistance.schemaVersion,
      migrationBlock: { _, _ in
    })
    Realm.Configuration.defaultConfiguration = config
    self.realm = try! Realm() // swiftlint:disable:this force_try

    // Setup user
    guard let fetchedUser = realm.objects(User.self).first else {
      // User not created, create new user
      try? realm.write {
        user = User(apiKey: apiKey)
        realm.add(user)
      }
      return
    }
    user = fetchedUser
  }
  
  internal func nuke() {
    try? realm.write {
      realm.deleteAll()
    }
  }
}
