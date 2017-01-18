// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseStudyQueueOperation: ParseOperation<StudyQueueInfo> {
  
  static let key = "requested_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> StudyQueueInfo? {
    guard let root = rootDictionary.first else { return nil}
    guard let studyQueueDict = root[ParseStudyQueueOperation.key] as? [String : AnyObject] else { return nil }
    let studyQueue = StudyQueueInfo(dict: studyQueueDict)
    return studyQueue
  }
  
}
