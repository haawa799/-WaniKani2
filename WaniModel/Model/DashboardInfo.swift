//
//  DashboardInfo.swift
//  WaniKit
//
//  Created by Andriy K. on 9/13/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public struct DashboardInfo: WaniKaniDataStructure {

  public let levelProgressionInfo: LevelProgressionInfo
  public let studyQueueInfo: StudyQueueInfo
  public let srs: SRSDistributionInfo
  public let lastLevelUpDate: Date?

  public init(levelProgressionInfo: LevelProgressionInfo, studyQueueInfo: StudyQueueInfo, srs: SRSDistributionInfo, lastLevelUpDate: Date?) {
    self.levelProgressionInfo = levelProgressionInfo
    self.studyQueueInfo = studyQueueInfo
    self.srs = srs
    self.lastLevelUpDate = lastLevelUpDate
  }

}
