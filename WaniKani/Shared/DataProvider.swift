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

  private let apiManager: WaniKitAPIManager

  init(apiKey: String) {
    apiManager = WaniKitAPIManager(apiKey: apiKey)
  }

  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
    apiManager.fetchDashboard(handler: handler)
  }

}
