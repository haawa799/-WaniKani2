//
//  RealmWord.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/1/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

public class RealmWord: RealmReviewItem {
  @objc public dynamic var character: String = ""
  @objc public dynamic var kana: String?
  @objc public dynamic var meaning: String?
  @objc public dynamic var level: Int = 0
  @objc public dynamic var percentage: String?
  @objc public dynamic var userSpecific: RealmUserSpecific?

  public override var item: Item? {
    var word = WordInfo(character: character, level: level)
    word.kana = kana
    word.meaning = meaning
    word.percentage = percentage
    word.userSpecific = userSpecific?.userSpecific
    return Item.word(word)
  }

  override public static func primaryKey() -> String? {
    return "character"
  }
}

public extension RealmWord {

  public func update(wordInfo: WordInfo) {
    character = wordInfo.character
    kana = wordInfo.kana
    meaning = wordInfo.meaning
    level = wordInfo.level
    percentage = wordInfo.percentage

    userSpecific?.update(userSpecificInfo: wordInfo.userSpecific)
  }

}
