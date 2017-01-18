//✅
//  DashboardCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

open class DashboardCoordinator: Coordinator, DashboardViewControllerDelegate/*, ReviewCoordinatorDelegate*/ {
  
  let presenter: UINavigationController
  let dashboardViewController: DashboardViewController
  fileprivate var reviewCoordinator: ReviewCoordinator?
  
  let dataProvider = DataProvider()
  
  public init(presenter: UINavigationController) {
    self.presenter = presenter
    dashboardViewController = DashboardViewController.instantiateViewController()
    let tabItem: UITabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "dashboard"), selectedImage: nil)
    presenter.tabBarItem = tabItem
  }
  
  
  func start() {
    dashboardViewController.delegate = self
    presenter.pushViewController(dashboardViewController, animated: false)
    _ = dashboardViewController.view
  }
  
}

// MARK: - DashboardViewControllerDelegate
extension DashboardCoordinator {
  
  func dashboardPullToRefreshAction() {
    fetchAllDashboardData()
  }
  
  func didSelectCell(_ indexPath: IndexPath) {
    switch (indexPath.section, indexPath.item) {
    case (1, 0): print("Lessons")
    case (1, 1): showReviews()
    default:
      break
    }
  }
  
  func showReviews() {
    reviewCoordinator = ReviewCoordinator(presenter: presenter, type: .review)
    reviewCoordinator?.start()
  }
  
}
