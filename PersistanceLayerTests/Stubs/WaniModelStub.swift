//
//  WaniModelStub.swift
//  WaniKani
//
//  Created by Andriy K. on 4/6/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel


enum WaniModelStub {
  case studyQueue(Int)
  case levelProgression(Int)
  case srs(Int)
  case radicals(Int)
  case kanji(Int)
  case words(Int)
  case recents(Int)
  case critical(Int)
  
  var fileName: String {
    switch self {
    case .studyQueue(let iteration): return "studyQueue\(iteration)"
    case .levelProgression(let iteration): return "levelProgression\(iteration)"
    case .srs(let iteration): return "srs\(iteration)"
    case .radicals(let iteration): return "radicals\(iteration)"
    case .kanji(let iteration): return "kanji\(iteration)"
    case .words(let iteration): return "words\(iteration)"
    case .recents(let iteration): return "recents\(iteration)"
    case .critical(let iteration): return "critical\(iteration)"
    }
  }
  
  var json: Any? {
    let bundle = Bundle(for: PersistanceLayerTests.classForCoder())
    guard let path = bundle.path(forResource: self.fileName, ofType: "json"),
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
      let json = try? JSONSerialization.jsonObject(with: data, options: [])
      else { return nil }
    return json
  }
  
  var dict: [String: Any]? {
    return json as? [String: Any]
  }
  
  var array: [[String: Any]]? {
    return json as? [[String: Any]]
  }
}

extension WaniModel.StudyQueueInfo {
  init(stub: WaniModelStub) {
    self.init(dict: stub.dict!)
  }
}

extension WaniModel.LevelProgressionInfo {
  init(stub: WaniModelStub) {
    let dict = stub.dict!
    let userDict = dict["user_information"] as! [String: Any]
    let requestedDict = dict["requested_information"] as! [String: Any]
    try! self.init(userInfoDict: userDict, requestedInfoDict: requestedDict)
  }
}

extension WaniModel.SRSDistributionInfo {
  init(stub: WaniModelStub) {
    try! self.init(dict: stub.dict!)
  }
}

extension WaniModel.RadicalInfo {
  static func listFrom(stub: WaniModelStub) -> [WaniModel.RadicalInfo] {
    return stub.array!.map { try! WaniModel.RadicalInfo(dict: $0) }
  }
}

extension WaniModel.KanjiInfo {
  static func listFrom(stub: WaniModelStub) -> [WaniModel.KanjiInfo] {
    return stub.array!.map { try! WaniModel.KanjiInfo(dict: $0) }
  }
}

extension WaniModel.WordInfo {
  static func listFrom(stub: WaniModelStub) -> [WaniModel.WordInfo] {
    return stub.array!.map { try! WaniModel.WordInfo(dict: $0) }
  }
}

extension WaniModel.ReviewItemInfo {
  static func listFrom(stub: WaniModelStub) -> [WaniModel.ReviewItemInfo] {
    do {
      return try stub.array!.map { try WaniModel.ReviewItemInfo(dict: $0) }
    } catch let e {
      print(e)
    }
    return []
  }
}
