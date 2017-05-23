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
        let q = apiManager.fetchKanjiPromise(level: 21)
        q.then({ [weak self] (kanji) in
            self?.persistance.persist(kanji: kanji)
        })
    }

}

// MARK: - WaniKitManagerDelegate
extension DataProvider: WaniKitManagerDelegate {
    func apiKeyIncorect() {
        delegate?.apiKeyIncorect()
    }
}
