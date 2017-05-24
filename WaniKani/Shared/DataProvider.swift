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
}

class DataProvider {

  private let apiManager: WaniKitManager
  let persistance: Persistance
  weak var delegate: DataProviderDelegate?

  init(apiKey: String, persistance: Persistance) {
    apiManager = WaniKitManager(apiKey: apiKey)
    self.persistance = persistance
    apiManager.delegate = self
  }

  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    apiManager.fetchDashboard().then { (dashboard) in
      handler(dashboard)
    }.catch { (error) in
        debugPrint(error)
        handler(nil)
    }
  }

    func fetchKanji() {
        let dispatchQueue = DispatchQueue(label: "Fetch all kanji queue")
        dispatchQueue.async {
            var kanjiArray = [KanjiInfo]()
            for level in 1...60 {
                let group = DispatchGroup()
                group.enter()
                let q = self.apiManager.fetchKanjiPromise(level: level)
                q.then({ (kanji) in
                    debugPrint("FFF:: level:\(level) count: \(kanji.count)")
                    kanjiArray.append(contentsOf: kanji)
                    group.leave()
                }).catch({ (_) in
                    group.leave()
                })
                group.wait()
            }
            debugPrint("FFF:: all \(kanjiArray.count)")
            DispatchQueue.main.async {
                self.persistance.persist(kanji: kanjiArray)
            }
        }
    }

    func fetchWords() {
        let dispatchQueue = DispatchQueue(label: "Fetch all words queue")
        dispatchQueue.async {
            var words = [WordInfo]()
            for level in 1...60 {
                let group = DispatchGroup()
                group.enter()
                let q = self.apiManager.fetchVocabPromise(level: level)
                q.then({ (vocab) in
                    debugPrint("FFF:: level:\(level) count: \(vocab.count)")
                    words.append(contentsOf: vocab)
                    group.leave()
                }).catch({ (_) in
                    group.leave()
                })
                group.wait()
            }
            debugPrint("FFF:: all \(words.count)")
            DispatchQueue.main.async {
                self.persistance.persist(words: words)
            }
        }
    }

    func fetchRadicals() {
        let dispatchQueue = DispatchQueue(label: "Fetch all radicals queue")
        dispatchQueue.async {
            var radicals = [RadicalInfo]()
            for level in 1...60 {
                let group = DispatchGroup()
                group.enter()
                let q = self.apiManager.fetchRadicalPromise(level: level)
                q.then({ (rads) in
                    debugPrint("FFF:: level:\(level) count: \(rads.count)")
                    radicals.append(contentsOf: rads)
                    group.leave()
                }).catch({ (_) in
                    group.leave()
                })
                group.wait()
            }
            debugPrint("FFF:: all \(radicals.count)")
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
