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

  convenience init(srsDistribution: WaniModel.SRSDistributionInfo) {
    self.init()
    self.apprentice = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.apprentice)
    self.guru = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.guru)
    self.master = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.master)
    self.enlighten = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.enlighten)
    self.burned = PersistanceLayer.SRSLevelInfo(srs: srsDistribution.burned)
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
