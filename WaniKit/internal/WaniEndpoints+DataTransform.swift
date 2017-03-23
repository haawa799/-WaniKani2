//
//  WaniEndpoint+DataTransform.swift
//  WaniKani
//
//  Created by Andriy K. on 3/20/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise
import WaniModel

// swiftlint:disable cyclomatic_complexity
internal extension WaniEndpoint {
  func dataTransformer(data: WaniParsedData) throws -> Any {
    switch self {
    case .userInfo(_):
      return try UserInfo(dict: data.userInfoDictionary)
    case .levelProgression(_):
      guard case let .dictionary(dict) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return try LevelProgressionInfo(userInfoDict: data.userInfoDictionary, requestedInfoDict: dict)
    case .criticalItems(_, _):
      guard case let .array(items) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return items.flatMap({ try? ReviewItemInfo(dict: $0) })
    case .radicalList(_, _):
      guard case let .array(items) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return items.flatMap({ try? RadicalInfo(dict: $0) })
    case .kanjiList(_, _):
      guard case let .array(items) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return items.flatMap({ try? KanjiInfo(dict: $0) })
    case .wordList(_, _):
      guard case let .array(items) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return items.flatMap({ try? WordInfo(dict: $0) })
    case .recentUnlocks(_, _):
      guard case let .array(items) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return items.flatMap({ try? ReviewItemInfo(dict: $0) })
    case .srsDistribution(_):
      guard case let .dictionary(dict) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return try SRSDistributionInfo(dict: dict)
    case .studyQueue(_):
      guard case let .dictionary(dict) = data.requestedInfo else { throw InitialisationError.mandatoryFieldsMissing }
      return StudyQueueInfo(dict: dict)
    }
  }
}
