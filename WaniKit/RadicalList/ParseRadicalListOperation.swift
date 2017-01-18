// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseRadicalListOperation: ParseOperation<[RadicalInfo]> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> [RadicalInfo]? {
    guard let root = rootDictionary.first else { return nil}
    guard let radicalDictArray = root[ParseStudyQueueOperation.key] as? [[String : AnyObject]] else { return nil }
    let radicalList = radicalDictArray.map({ RadicalInfo(dict: $0) })
    return radicalList
  }
  
}
