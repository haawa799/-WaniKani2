// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import PSOperations
import WaniModel

public class DashboardInfoGroupOperation: PSOperations.GroupOperation {
  
  private var studyQueue: StudyQueueInfo?
  private var progression: LevelProgressionInfo?
  private var lastLevelUpDate: Date?
  private var srs: SRSDistributionInfo?
  
  public init(baseURL: URL, handler: @escaping (DashboardInfo?) -> Void) {
    
    super.init(operations: [])
    
    let studyQueueOperation = StudyQueueGroupOperation(baseURL: baseURL) { (studyQueue, responseCode) in
      self.studyQueue = studyQueue
    }
    let progressionOperation = LevelProgressionGroupOperation(baseURL: baseURL) { (progression, responseCode) in
      self.progression = progression
    }
    
    let lastLevelUpOperation = LastLevelUpGroupOperation(baseURL: baseURL) { (date) in
      self.lastLevelUpDate = date
    }
    
    let srsOperation = SRSDistributionGroupOperation(baseURL: baseURL) { (srs, responseCode) in
      self.srs = srs
    }
    
    let completionOperation = PSOperations.BlockOperation { ( _ ) in
      guard let studyQueue = self.studyQueue, let progression = self.progression, let srs = self.srs else {
        handler(nil)
        return
      }
      let dashboardData = DashboardInfo(levelProgressionInfo: progression, studyQueueInfo: studyQueue, srs: srs, lastLevelUpDate: self.lastLevelUpDate)
      handler(dashboardData)
    }
    
    completionOperation.addDependency(studyQueueOperation)
    completionOperation.addDependency(progressionOperation)
    completionOperation.addDependency(lastLevelUpOperation)
    completionOperation.addDependency(srsOperation)
    
    addOperation(studyQueueOperation)
    addOperation(progressionOperation)
    addOperation(lastLevelUpOperation)
    addOperation(srsOperation)
    addOperation(completionOperation)
  }
}
