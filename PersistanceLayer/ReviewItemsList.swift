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

public class ReviewItemsList: Object, WaniModelConvertable {

  public typealias PersistantType = PersistanceLayer.ReviewItemsList
  public typealias WaniType = [WaniModel.ReviewItemInfo]

  public var items = List<ReviewItemInfo>()

  public convenience required init(model: WaniType) {
    self.init()
    self.items = List<ReviewItemInfo>()
    items.append(contentsOf: model.map { ReviewItemInfo(model: $0) })
  }

  public var waniModelStruct: WaniType {
    return self.items.map { $0.waniModelStruct }
  }
}
