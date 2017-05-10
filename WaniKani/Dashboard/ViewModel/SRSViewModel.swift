//
//  SRSViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 9/20/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit
import WaniModel

struct SRSViewModel: SRSViewDataSource {

  fileprivate let topTitleString: String

  init(srs: SRSLevelInfo) {
    topTitleString = "\(srs.total)"
  }
}

// MARK: - DashboardHeaderDatasource
extension SRSViewModel {

  var topTitle: String {
    return topTitleString
  }

}
