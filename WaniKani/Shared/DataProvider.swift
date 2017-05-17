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
import Promise

protocol DataProviderDelegate: class {
    func apiKeyIncorect()
}

class DataProvider {

  private let apiManager: WaniKitManager
  weak var delegate: DataProviderDelegate?

  init(apiKey: String) {
    apiManager = WaniKitManager(apiKey: apiKey)
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

}

// MARK: - WaniKitManagerDelegate
extension DataProvider: WaniKitManagerDelegate {
    func apiKeyIncorect() {
        delegate?.apiKeyIncorect()
    }
}
