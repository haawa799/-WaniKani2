// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseLevelProgressionOperation: ParseOperation<LevelProgressionInfo> {
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> LevelProgressionInfo? {
    guard let root = rootDictionary.first else { return nil}

    let levelProgression = LevelProgressionInfo(dict: root)
    return levelProgression
  }
  
}
