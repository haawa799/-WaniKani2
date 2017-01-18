// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseSRSDistributionOperation: ParseOperation<SRSDistributionInfo> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> SRSDistributionInfo? {
    guard let root = rootDictionary.first else { return nil}
    guard let srsDict = root[ParseSRSDistributionOperation.key ] as? [String : AnyObject] else { return nil }
    let srs = SRSDistributionInfo(dict: srsDict)
    return srs
  }
  
}
