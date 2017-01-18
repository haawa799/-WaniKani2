// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseRecentUnlocksOperation: ParseOperation<[ReviewItemInfo]> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> [ReviewItemInfo]? {
    guard let root = rootDictionary.first else { return nil }
    guard let itemsListArray = root[ParseStudyQueueOperation.key] as? [[String : AnyObject]] else { return nil }
    let itemsList = itemsListArray.flatMap({ ReviewItemInfo(dict: $0) })
    return itemsList
  }
  
}
