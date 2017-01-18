// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseWordListOperation: ParseOperation<[WordInfo]> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> [WordInfo]? {
    guard let root = rootDictionary.first else { return nil}
    guard let wordsDictArray = root[ParseStudyQueueOperation.key] as? [[String : AnyObject]] else { return nil }
    let wordsList = wordsDictArray.map({ WordInfo(dict: $0) })
    return wordsList
  }
  
}
