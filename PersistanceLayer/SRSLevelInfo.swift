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

class SRSLevelInfo: Object {
  dynamic var radicals: Int = 0
  dynamic var kanji: Int = 0
  dynamic var vocabulary: Int = 0
  dynamic var total: Int = 0
  dynamic var label: String = ""

  override static func primaryKey() -> String? {
    return "label"
  }

  convenience init(srs: WaniModel.SRSLevelInfo, label: String) {
    self.init()
    self.label = label
    self.radicals = srs.radicals
    self.kanji = srs.kanji
    self.vocabulary = srs.vocabulary
    self.total = srs.total
  }

  var waniModelStruct: WaniModel.SRSLevelInfo {
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
