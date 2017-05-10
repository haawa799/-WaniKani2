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

class DataProvider {

  private let apiManager: WaniKitManager

  init(apiKey: String) {
    apiManager = WaniKitManager(apiKey: apiKey)
  }

  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    apiManager.fetchDashboard().then { (dashboard) in
      handler(dashboard)
    }
  }

}
