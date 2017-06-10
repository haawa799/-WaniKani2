//✅
//  DataProvider.swift
//  WaniKani
//
//  Created by Andriy K. on 9/19/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import WaniKit
import WaniModel
import WaniPersistance
import Promise

protocol DataProviderDelegate: class {
  func apiKeyIncorect()
  func userDidLevelUp(oldLevel: Int, newLevel: Int)
}

class DataProvider {

  private let apiManager: WaniKitManager
  private let activityManager = UserActivityManager()
  let persistance: Persistance
  weak var delegate: DataProviderDelegate?
  var currentLevel: Int {
    return persistance.levelProgression?.userInfo.level ?? 0
  }

  var maxLevel: Int {
    return currentLevel <= 3 ? currentLevel : 60
  }

  init(apiKey: String, persistance: Persistance) {
    apiManager = WaniKitManager(apiKey: apiKey)
    self.persistance = persistance
    apiManager.delegate = self
  }

  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    apiManager.fetchDashboard().then { [weak self] (dashboard) in
      if let nextReview = dashboard.studyQueueInfo.nextReviewDate {
        NotificationManager.sharedInstance.scheduleNextReviewNotification(date: nextReview)
      }
      NotificationManager.sharedInstance.updateIconCounter(number: dashboard.studyQueueInfo.reviewsAvaliable ?? 0)
      self?.activityManager.newStudyQueueData(studyQueue: dashboard.studyQueueInfo)
      self?.persistance.persist(levelProgression: dashboard.levelProgressionInfo)
      if let oldLevel = self?.persistance.levelProgression?.userInfo.level {
        let newLevel = dashboard.levelProgressionInfo.userInfo.level
        if (newLevel - oldLevel) > 0 {
            self?.delegate?.userDidLevelUp(oldLevel: oldLevel, newLevel: newLevel)
        }
      }
      handler(dashboard)
      }.catch { (error) in
        debugPrint(error)
        handler(nil)
    }
  }

  func fetchKanji(queue: DispatchQueue = DispatchQueue(label: "Fetch all kanji queue"), kanjiFetchedBlock: @escaping (_ success: Bool) -> Void) {
    let maxLevel = self.maxLevel
    queue.async {
      var kanjiArray = [KanjiInfo]()
      for level in 1...maxLevel {
        let group = DispatchGroup()
        group.enter()
        let q = self.apiManager.fetchKanjiPromise(level: level)
        q.then({ (kanji) in
          kanjiArray.append(contentsOf: kanji)
          kanjiFetchedBlock(true)
          group.leave()
        }).catch({ (_) in
          kanjiFetchedBlock(false)
          group.leave()
        })
        group.wait()
      }
      DispatchQueue.main.async {
        self.persistance.persist(kanji: kanjiArray)
      }
    }
  }

  func fetchWords(queue: DispatchQueue = DispatchQueue(label: "Fetch all words queue"), wordsFetchedBlock: @escaping (_ success: Bool) -> Void) {
    let maxLevel = self.maxLevel
    queue.async {
      var words = [WordInfo]()
      for level in 1...maxLevel {
        let group = DispatchGroup()
        group.enter()
        let q = self.apiManager.fetchVocabPromise(level: level)
        q.then({ (vocab) in
          words.append(contentsOf: vocab)
          wordsFetchedBlock(true)
          group.leave()
        }).catch({ (_) in
          wordsFetchedBlock(false)
          group.leave()
        })
        group.wait()
      }
      DispatchQueue.main.async {
        self.persistance.persist(words: words)
      }
    }
  }

    func fetchRadicals(queue: DispatchQueue = DispatchQueue(label: "Fetch all radicals queue"), radicalsFetchedBlock: @escaping (_ success: Bool) -> Void) {
      let maxLevel = self.maxLevel
    queue.async {
      var radicals = [RadicalInfo]()
      for level in 1...maxLevel {
        let group = DispatchGroup()
        group.enter()
        let q = self.apiManager.fetchRadicalPromise(level: level)
        q.then({ (rads) in
          radicals.append(contentsOf: rads)
          radicalsFetchedBlock(true)
          group.leave()
        }).catch({ (_) in
          radicalsFetchedBlock(false)
          group.leave()
        })
        group.wait()
      }
      DispatchQueue.main.async {
        self.persistance.persist(radicals: radicals)
      }
    }
  }

}

// MARK: - WaniKitManagerDelegate
extension DataProvider: WaniKitManagerDelegate {
  func apiKeyIncorect() {
    delegate?.apiKeyIncorect()
  }
}
