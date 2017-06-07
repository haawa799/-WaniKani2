//
//  RealmComplicationItem.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/6/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

public class RealmComplicationItem: Object {
  public dynamic var text = ""
  public dynamic var subText: String?
  public dynamic var date: Date = Date()

  public var itemType: RealmReviewItem.ItemType {
    return RealmReviewItem.ItemType(rawValue: type)!
  }
  public dynamic var type: Int = 0

  public static func newItem(itemInfo: Item, date: Date) -> RealmComplicationItem {
    let item = RealmComplicationItem()
    switch itemInfo {
    case .radical(let radicalInfo):
      item.text = radicalInfo.character ?? ""
      item.type = RealmReviewItem.ItemType.radical.rawValue
    case .kanji(let kanjiInfo):
      item.text = kanjiInfo.character
      item.type = RealmReviewItem.ItemType.kanji.rawValue
    case .word(let wordInfo):
      item.text = wordInfo.character
      item.type = RealmReviewItem.ItemType.word.rawValue
    }
    item.subText = itemInfo.typeDescription
    item.date = date
    return item
  }

  public var item: ComplicationItem {
    let item = ComplicationItem(text: self.text, subText: subText, date: date, color: itemType.color, type: type)
    return item
  }

}
