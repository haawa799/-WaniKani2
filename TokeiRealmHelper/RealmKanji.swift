//
//  RealmKanji.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/1/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

public class RealmKanji: RealmReviewItem {
  public dynamic var character = ""
  public dynamic var meaning: String?
  public dynamic var onyomi: String?
  public dynamic var kunyomi: String?
  public dynamic var nanori: String?
  public dynamic var importantReading: String?
  public dynamic var level = 0
  public dynamic var percentage: String?
  public dynamic var userSpecific: RealmUserSpecific?

  public override var item: Item? {
    var kanji = KanjiInfo(character: character, level: level)
    kanji.meaning = meaning
    kanji.onyomi = onyomi
    kanji.kunyomi = kunyomi
    kanji.nanori = nanori
    kanji.importantReading = importantReading
    kanji.percentage = percentage
    kanji.userSpecific = userSpecific?.userSpecific
    return Item.kanji(kanji)
  }

  override public static func primaryKey() -> String? {
    return "character"
  }
}

public extension RealmKanji {

  public func update(kanjiInfo: KanjiInfo) {
    character = kanjiInfo.character
    meaning = kanjiInfo.meaning
    onyomi = kanjiInfo.onyomi
    kunyomi = kanjiInfo.kunyomi
    nanori = kanjiInfo.nanori
    importantReading = kanjiInfo.importantReading
    level = kanjiInfo.level
    percentage = kanjiInfo.percentage
    userSpecific?.update(userSpecificInfo: kanjiInfo.userSpecific)
  }

}
