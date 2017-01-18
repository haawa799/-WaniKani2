// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import PSOperations

public class LastLevelUpGroupOperation: PSOperations.GroupOperation {
  
  private var lastLevelUpDate: Date?
  
  public init(baseURL: URL, handler: @escaping (Date?) -> Void) {
    
    super.init(operations: [])
    
    let recentOperation = RecentUnlocksGroupOperation(baseURL: baseURL, limit: 1) { (items, responseCode) in
      guard let item = items?.first else { return }
      self.lastLevelUpDate = item.unlockedDate
    }
    
    let completionOperation = PSOperations.BlockOperation { ( _ ) in
      handler(self.lastLevelUpDate)
    }
    
    completionOperation.addDependency(recentOperation)
    
    addOperation(recentOperation)
    addOperation(completionOperation)
  }
}
