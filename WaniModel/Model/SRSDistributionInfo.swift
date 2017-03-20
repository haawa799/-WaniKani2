//
//  SRSDistribution.swift
//  WaniKit
//
//  Created by Andriy K. on 9/13/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public struct SRSDistributionInfo: WaniKaniDataStructure {

  struct DictionaryKey {
    static let apprentice = "apprentice"
    static let guru = "guru"
    static let master = "master"
    static let enlighten = "enlighten"
    static let burned = "burned"
  }

  public let apprentice: SRSLevelInfo
  public let guru: SRSLevelInfo
  public let master: SRSLevelInfo
  public let enlighten: SRSLevelInfo
  public let burned: SRSLevelInfo

  public var all: [SRSLevelInfo] {
    return [apprentice, guru, master, enlighten, burned]
  }

}

extension SRSDistributionInfo {

  public init(dict: [String : Any]) throws {
    guard let apprenticeDict = dict[DictionaryKey.apprentice] as? [String: Any],
          let guruDict = dict[DictionaryKey.guru] as? [String : Any],
          let masterDict = dict[DictionaryKey.master] as? [String : Any],
          let enlightenDict = dict[DictionaryKey.enlighten] as? [String : Any],
          let burnedDict = dict[DictionaryKey.burned] as? [String : Any] else { throw InitialisationError.mandatoryFieldsMissing }

    // Apprentice
    apprentice = SRSLevelInfo(dict: apprenticeDict)

    // Guru
    guru = SRSLevelInfo(dict: guruDict)

    // Master
    master = SRSLevelInfo(dict: masterDict)

    // Enlighten
    enlighten = SRSLevelInfo(dict: enlightenDict)

    // Burned
    burned = SRSLevelInfo(dict: burnedDict)
  }
}
