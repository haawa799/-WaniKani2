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

public class ReviewItemInfo: Object, WaniModelConvertable {

  public typealias PersistantType = PersistanceLayer.ReviewItemInfo
  public typealias WaniType = WaniModel.ReviewItemInfo

  public dynamic var radical: PersistanceLayer.RadicalInfo?
  public dynamic var kanji: PersistanceLayer.KanjiInfo?
  public dynamic var word: PersistanceLayer.WordInfo?
  public dynamic var mainTitle: String = ""
  public dynamic var percentage: String?

  override public static func primaryKey() -> String? {
    return "mainTitle"
  }

  public convenience required init(model: WaniType) {
    self.init()
    self.mainTitle = model.mainTitle
    self.percentage = model.percentage
  }

  public var waniModelStruct: WaniType {
    return ReviewItemInfo.WaniType(realmObject: self)
  }
}

extension ReviewItemInfo.WaniType: PersistanceModelInstantiatible {

  public typealias PersistantType = PersistanceLayer.ReviewItemInfo

  public init(realmObject: PersistantType) {
    let item: Any? = realmObject.word ?? realmObject.kanji ?? realmObject.radical ?? nil
    switch item {
      case let item as PersistanceLayer.KanjiInfo: self = .kanji(item.waniModelStruct)
      case let item as PersistanceLayer.WordInfo: self = .word(item.waniModelStruct)
      case let item as PersistanceLayer.RadicalInfo: self = .radical(item.waniModelStruct)
      default: fatalError()
    }
  }
}
