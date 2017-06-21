//
//  DoubleProgressBarViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 3/18/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import WaniModel

struct DoubleProgressViewModel: DoubleProgressBarProgressDataSource {

  private let topProgressString: String
  private let botProgressString: String
  private let topProgress: CGFloat
  private let botProgress: CGFloat
  private let userLevelString: String

  init(dashboard: DashboardInfo) {
    guard let topMax = dashboard.levelProgressionInfo.kanjiTotal,
      let topCur = dashboard.levelProgressionInfo.kanjiProgress,
      let botMax = dashboard.levelProgressionInfo.radicalsTotal,
      let botCur = dashboard.levelProgressionInfo.radicalsProgress else {
        topProgressString = ""
        botProgressString = ""
        topProgress = 0
        botProgress = 0
        userLevelString = ""
        return
    }

    topProgressString = "\(topCur)/\(topMax)"
    botProgressString = "\(botCur)/\(botMax)"

    topProgress = CGFloat(topCur)/CGFloat(topMax)
    botProgress = CGFloat(botCur)/CGFloat(botMax)
    userLevelString = "\(dashboard.levelProgressionInfo.userInfo.level)"
  }

}

// MARK: - DoubleProgressBarProgressDataSource
extension DoubleProgressViewModel {
  var topTitle: String { return topProgressString }
  var botTitle: String { return botProgressString }
  var topProgressPercentage: CGFloat { return topProgress }
  var botProgressPercentage: CGFloat { return botProgress }
  var levelString: String { return userLevelString }
}
