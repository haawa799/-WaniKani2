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

struct DataProvider {
  
  private var apiManager: WaniKitAPIManager = {
    var manager = WaniKitAPIManager()
    manager.changeApiKey(newKey: "c6ce4072cf1bd37b407f2c86d69137e3")
    return manager
  }()
  
  mutating func setNewAPIKey(newKey: String) {
    apiManager.changeApiKey(newKey: "c6ce4072cf1bd37b407f2c86d69137e3")
  }
  
  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    apiManager.fetchDashboard(handler: handler)
  }
  
}
