//
//  ReviewItemsList.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel

class ReviewItemsList: Object {

  typealias PersistantType = PersistanceLayer.ReviewItemsList
  typealias WaniType = [WaniModel.ReviewItemInfo]

  var items = List<ReviewItemInfo>()
  dynamic var label = ""
  override static func primaryKey() -> String? {
    return "label"
  }

  convenience required init(model: WaniType, label: String, realm: Realm) {
    self.init()
    self.label = label
    let updatedItems = model.map { ReviewItemInfo(model: $0, realm: realm) }
    realm.add(updatedItems)
    self.items = List<ReviewItemInfo>()
    items.append(contentsOf: updatedItems)
  }

  var waniModelStruct: WaniType {
    return self.items.map { $0.waniModelStruct }
  }

}
