//
//  Persistance+Save.swift
//  WaniKani
//
//  Created by Andriy K. on 4/3/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel

public extension Persistance {

  public func persist(levelProgression: WaniModel.LevelProgressionInfo) {
    try? realm.write {
      let updated = LevelProgressionInfo(levelProgression: levelProgression, realm: realm, userId: user.apiKey)
      realm.add(updated, update: true)
      user.levelProgression = updated
    }
  }

  public func persist(studyQueue: WaniModel.StudyQueueInfo) {
    try? realm.write {
      let updated = StudyQueueInfo(studyQueue: studyQueue, userId: user.apiKey)
      realm.add(updated, update: true)
      user.studyQueue = updated
    }
  }

  public func persist(srs: WaniModel.SRSDistributionInfo) {
    try? realm.write {
      let updated = SRSDistributionInfo(srsDistribution: srs, userId: user.apiKey)
      realm.add(updated, update: true)
      user.srs = updated
    }
  }

  public func persist(criticalItems: [WaniModel.ReviewItemInfo]) {
    try? realm.write {
      if let oldItems = user.criticalItems?.items { realm.delete(oldItems) }
      let updated = ReviewItemsList(model: criticalItems, label: "criticalItems", realm: realm)
      realm.add(updated, update: true)
      user.criticalItems = updated
    }
  }

  public func persist(recents: [WaniModel.ReviewItemInfo]) {
    try? realm.write {
      if let oldItems = user.recentsItems?.items { realm.delete(oldItems) }
      let updated = ReviewItemsList(model: recents, label: "recentsUnlocks", realm: realm)
      realm.add(updated, update: true)
      user.recentsItems = updated
    }
  }

  public func persist(kanji: [WaniModel.KanjiInfo]) {
    let updated = kanji.map { KanjiInfo(model: $0) }
    try? realm.write {
      realm.add(updated, update: true)
    }
  }

  public func persist(radicals: [WaniModel.RadicalInfo]) {
    let updated = radicals.map { RadicalInfo(model: $0) }
    try? realm.write {
      realm.add(updated, update: true)
    }
  }

  public func persist(words: [WaniModel.WordInfo]) {
    let updated = words.map { WordInfo(model: $0) }
    try? realm.write {
      realm.add(updated, update: true)
    }
  }
}
