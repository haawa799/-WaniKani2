//
//  RealmCriticalList.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/2/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit
import RealmSwift
import WaniModel

public class RealmReviewItem: Object {

  public enum ItemType: Int {
    case radical = 0
    case kanji = 1
    case word = 2

    var color: UIColor {
      switch self {
      case .radical: return UIColor(red:0.09, green:0.59, blue:0.87, alpha:1.00)
      case .kanji: return UIColor(red:0.92, green:0.12, blue:0.39, alpha:1.00)
      case .word: return UIColor(red:0.60, green:0.22, blue:0.69, alpha:1.00)
      }
    }
  }

  public var item: Item? {
    switch itemType {
    case .radical: return radical?.item
    case .kanji: return kanji?.item
    case .word: return word?.item
    }
  }

  public var itemType: ItemType {
    return ItemType(rawValue: type)!
  }

  public dynamic var type: Int = 0
  public dynamic var text: String = ""
  public dynamic var radical: RealmRadical?
  public dynamic var kanji: RealmKanji?
  public dynamic var word: RealmWord?

  public static func newItem(itemInfo: Item?) -> RealmReviewItem? {
    guard let itemInfo = itemInfo else { return nil }
    let item = RealmReviewItem()
    switch itemInfo {
    case .radical(let radicalInfo):
      let radical = RealmRadical()
      radical.update(radicalInfo: radicalInfo)
      item.radical = radical
      item.type = ItemType.radical.rawValue
      item.text = radicalInfo.character ?? ""
      return item
    case .kanji(let kanjiInfo):
      let kanji = RealmKanji()
      kanji.update(kanjiInfo: kanjiInfo)
      item.kanji = kanji
      item.type = ItemType.kanji.rawValue
      item.text = kanjiInfo.character
      return item
    case .word(let wordInfo):
      let word = RealmWord()
      word.update(wordInfo: wordInfo)
      item.word = word
      item.type = ItemType.word.rawValue
      item.text = wordInfo.character
      return item
    }
  }
}

public class RealmReviewItemsList: Object {

  let items = List<RealmReviewItem>()

  public func populateWithNewItems(items: [Item]) {
    self.items.removeAll()
    let realmItems = items.flatMap({ RealmReviewItem.newItem(itemInfo: $0) })
    self.items.append(objectsIn: realmItems)
  }

  public func convertedItems() -> [Item] {
    return items.flatMap({ $0.item })
  }

}
