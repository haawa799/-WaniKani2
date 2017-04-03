//
//  SRSLevelInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

public class SRSLevelInfo: Object {
  public dynamic var radicals: Int = 0
  public dynamic var kanji: Int = 0
  public dynamic var vocabulary: Int = 0
  public dynamic var total: Int = 0

  public convenience init(srs: WaniModel.SRSLevelInfo) {
    self.init()
    self.radicals = srs.radicals
    self.kanji = srs.kanji
    self.vocabulary = srs.vocabulary
    self.total = srs.total
  }

  public var waniModelStruct: WaniModel.SRSLevelInfo {
    return WaniModel.SRSLevelInfo(realmObject: self)
  }
}

extension WaniModel.SRSLevelInfo {

  init(realmObject: PersistanceLayer.SRSLevelInfo) {
    self.radicals = realmObject.radicals
    self.kanji = realmObject.kanji
    self.vocabulary = realmObject.vocabulary
    self.total = realmObject.total
  }

}
