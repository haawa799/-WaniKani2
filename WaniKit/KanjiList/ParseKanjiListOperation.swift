// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseKanjiListOperation: ParseOperation<[KanjiInfo]> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> [KanjiInfo]? {
    guard let root = rootDictionary.first else { return nil}
    guard let kanjiDictArray = root[ParseStudyQueueOperation.key] as? [[String : AnyObject]] else { return nil }
    let kanjiList = kanjiDictArray.map({ KanjiInfo(dict: $0) })
    return kanjiList
  }
  
}
