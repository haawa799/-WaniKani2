//
//  RealmRadical.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/1/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

public class RealmRadical: RealmReviewItem {
  @objc public dynamic var character: String?
  @objc public dynamic var meaning: String?
  @objc public dynamic var image: String?
  @objc public dynamic var level = 0
  @objc public dynamic var percentage: String?
  @objc public dynamic var userSpecific: RealmUserSpecific?

  public override var item: Item? {
    var radical = RadicalInfo(level: level)
    radical.character = character
    radical.meaning = meaning
    radical.image = image
    radical.percentage = percentage
    radical.userSpecific = userSpecific?.userSpecific
    return Item.radical(radical)
  }

  override public static func primaryKey() -> String? {
    return "character"
  }
}

public extension RealmRadical {

  public func update(radicalInfo: RadicalInfo) {
    character = radicalInfo.character
    meaning = radicalInfo.meaning
    image = radicalInfo.image
    level = radicalInfo.level
    percentage = radicalInfo.percentage
    userSpecific?.update(userSpecificInfo: radicalInfo.userSpecific)
  }

}
