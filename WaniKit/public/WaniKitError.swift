//
//  WaniKitError.swift
//  WaniKani
//
//  Created by Andriy K. on 3/23/17.
//  Copyright © 2017 haawa. All rights reserved.
//

public enum WaniKitError: Error {
  case noRecentUnlocks
  case studyQueueNotLoaded
  case levelProgressionNotLoaded
  case srsNotLoaded
  case lastLevelUpNotLoaded
  case onOfFieldsNotLoadedButCounterIncreased
  case typeCastError
}

public enum ParsingError: Error {
  case noRoot
  case noUserInfo
  case noRequestedInfo
}
