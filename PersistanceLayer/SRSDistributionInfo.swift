//
//  SRSDistributionInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class SRSDistributionInfo: Object {
  dynamic var apprentice: PersistanceLayer.SRSLevelInfo!
  dynamic var guru: PersistanceLayer.SRSLevelInfo!
  dynamic var master: PersistanceLayer.SRSLevelInfo!
  dynamic var enlighten: PersistanceLayer.SRSLevelInfo!
  dynamic var burned: PersistanceLayer.SRSLevelInfo!
  dynamic var userId: String = ""

  override static func primaryKey() -> String? {
    return "userId"
  }

  convenience init(srsDistribution: WaniModel.SRSDistributionInfo, userId: String) {
    self.init()
    self.userId = userId
    self.apprentice = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.apprentice, label: "apprentice")
    self.guru = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.guru, label: "guru")
    self.master = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.master, label: "master")
    self.enlighten = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.enlighten, label: "enlighten")
    self.burned = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.burned, label: "burned")
  }

  var waniModelStruct: WaniModel.SRSDistributionInfo {
    return WaniModel.SRSDistributionInfo(realmObject: self)
  }

  func willBeDeleted(realm: Realm) {
    realm.delete(apprentice)
    realm.delete(guru)
    realm.delete(master)
    realm.delete(enlighten)
    realm.delete(burned)
  }
}

extension WaniModel.SRSDistributionInfo {

  init(realmObject: PersistanceLayer.SRSDistributionInfo) {
    self.apprentice = realmObject.apprentice.waniModelStruct
    self.guru = realmObject.guru.waniModelStruct
    self.master = realmObject.master.waniModelStruct
    self.enlighten = realmObject.enlighten.waniModelStruct
    self.burned = realmObject.burned.waniModelStruct
  }

}
