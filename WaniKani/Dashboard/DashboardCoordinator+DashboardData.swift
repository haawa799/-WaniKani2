//
//  Q.swift
//  WaniKani
//
//  Created by Andriy K. on 3/25/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import WaniModel

// MARK: - Dashboard data fetch
public extension DashboardCoordinator {

  public func fetchAllDashboardData() {
    dataProvider.fetchDashboard { (dashboard) in
      guard let dashboard = dashboard else { return }
      guard let dashboardViewModel = DashboardViewModel(dashboardInfo: dashboard) else { return }
      let progressViewModel = DoubleProgressViewModel(dashboard: dashboard)
      let srsViewModel = SRSDistributionViewModel(srs: dashboard.srs)
      self.dashboardViewController.updateDashboardWithViewModels(progressViewModel: progressViewModel, collectionViewModel: dashboardViewModel.listViewModel, srsViewModel: srsViewModel, isOld: false)
    }
  }

}
