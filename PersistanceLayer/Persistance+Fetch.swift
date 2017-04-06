//
//  Persistance+Fetch.swift
//  WaniKani
//
//  Created by Andriy K. on 4/6/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel

public extension Persistance {

  var levelProgression: WaniModel.LevelProgressionInfo? {
    return user.levelProgression?.waniModelStruct
  }

  var studyQueue: WaniModel.StudyQueueInfo? {
    return user.studyQueue?.waniModelStruct
  }

  var srs: WaniModel.SRSDistributionInfo? {
    return user.srs?.waniModelStruct
  }

  var criticalItems: [WaniModel.ReviewItemInfo]? {
    return user.criticalItems?.waniModelStruct
  }

  var recentsItems: [WaniModel.ReviewItemInfo]? {
    return user.recentsItems?.waniModelStruct
  }
  
  func radicalsForLevel(level: Int) -> [WaniModel.RadicalInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(PersistanceLayer.RadicalInfo.self).filter(predicate).map { $0.waniModelStruct }
  }

  func kanjiForLevel(level: Int) -> [WaniModel.KanjiInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(PersistanceLayer.KanjiInfo.self).filter(predicate).map { $0.waniModelStruct }
  }

  func wordsForLevel(level: Int) -> [WaniModel.WordInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(PersistanceLayer.WordInfo.self).filter(predicate).map { $0.waniModelStruct }
  }
}

extension Persistance {
  var allKanji: [WaniModel.KanjiInfo] {
    return realm.objects(PersistanceLayer.KanjiInfo.self).map { $0.waniModelStruct }
  }
  var allRadicals: [WaniModel.RadicalInfo] {
    return realm.objects(PersistanceLayer.RadicalInfo.self).map { $0.waniModelStruct }
  }
  var allWords: [WaniModel.WordInfo] {
    return realm.objects(PersistanceLayer.WordInfo.self).map { $0.waniModelStruct }
  }
}
