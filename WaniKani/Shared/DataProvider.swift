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

  private let apiManager: WaniKitManager

  init(apiKey: String) {
    apiManager = WaniKitManager(apiKey: apiKey)
  }

  func fetchDashboard(handler: @escaping (DashboardInfo?) -> Void) {
//    apiManager.fetchDashboard(handler: handler)
  }

}
