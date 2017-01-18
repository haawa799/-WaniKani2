//
//  SRSDistribution.swift
//  WaniKit
//
//  Created by Andriy K. on 9/13/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public struct SRSDistributionInfo {
  
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
  
  public init(dict: [String : AnyObject]) {
    // Apprentice
    let apprenticeDict = dict[DictionaryKey.apprentice] as! [String : AnyObject]
    apprentice = SRSLevelInfo(dict: apprenticeDict)
    
    // Guru
    let guruDict = dict[DictionaryKey.guru] as! [String : AnyObject]
    guru = SRSLevelInfo(dict: guruDict)
    
    // Master
    let masterDict = dict[DictionaryKey.master] as! [String : AnyObject]
    master = SRSLevelInfo(dict: masterDict)
    
    // Enlighten
    let enlightenDict = dict[DictionaryKey.enlighten] as! [String : AnyObject]
    enlighten = SRSLevelInfo(dict: enlightenDict)
    
    // Burned
    let burnedDict = dict[DictionaryKey.burned] as! [String : AnyObject]
    burned = SRSLevelInfo(dict: burnedDict)
  }
}
