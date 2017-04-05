//
//  WordInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class ReviewItemInfo: Object {

  typealias PersistantType = PersistanceLayer.ReviewItemInfo
  typealias WaniType = WaniModel.ReviewItemInfo

  dynamic var radical: PersistanceLayer.RadicalInfo?
  dynamic var kanji: PersistanceLayer.KanjiInfo?
  dynamic var word: PersistanceLayer.WordInfo?
  dynamic var mainTitle: String = ""
  dynamic var percentage: String?
  dynamic var key: String = ""

  override static func primaryKey() -> String? {
    return "key"
  }

  convenience required init(model: WaniType, realm: Realm) {
    self.init()
    self.mainTitle = model.mainTitle
    self.percentage = model.percentage
    let type: String

    switch model {
      case .radical(let radicalModel):
        let updated = RadicalInfo(model: radicalModel)
        if let old = realm.object(ofType: RadicalInfo.self, forPrimaryKey: updated.key) {
          updated.userSpecific = old.userSpecific
          updated.unlockedDate = old.unlockedDate
        }
        realm.add(updated, update: true)
        self.radical = updated
        type = "radical"
      case .kanji(let kanjiModel):
        let updated = KanjiInfo(model: kanjiModel)
        if let old = realm.object(ofType: KanjiInfo.self, forPrimaryKey: updated.character) {
          updated.userSpecific = old.userSpecific
          updated.unlockedDate = old.unlockedDate
        }
        realm.add(updated, update: true)
        self.kanji = updated
        type = "kanji"
      case .word(let wordModel):
        let updated = WordInfo(model: wordModel)
        if let old = realm.object(ofType: WordInfo.self, forPrimaryKey: updated.character) {
          updated.userSpecific = old.userSpecific
          updated.unlockedDate = old.unlockedDate
        }
        realm.add(updated, update: true)
        self.word = updated
        type = "word"
    }
    self.key = "\(type)::\(mainTitle)"
  }

  var waniModelStruct: WaniType {
    return ReviewItemInfo.WaniType(realmObject: self)
  }
}

extension ReviewItemInfo.WaniType: PersistanceModelInstantiatible {

  typealias PersistantType = PersistanceLayer.ReviewItemInfo

  init(realmObject: PersistantType) {
    let item: Any? = realmObject.word ?? realmObject.kanji ?? realmObject.radical ?? nil
    switch item {
      case let item as PersistanceLayer.KanjiInfo: self = .kanji(item.waniModelStruct)
      case let item as PersistanceLayer.WordInfo: self = .word(item.waniModelStruct)
      case let item as PersistanceLayer.RadicalInfo: self = .radical(item.waniModelStruct)
      default: fatalError()
    }
  }
}
