//✅
//  DashboardCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

class DashboardCoordinator: Coordinator, DashboardViewControllerDelegate/*, ReviewCoordinatorDelegate*/ {

  struct Constants {
    static let dashboardTitle = "Dashboard"

    struct Path {
      static let lesson = IndexPath(item: 0, section: 1)
      static let review = IndexPath(item: 1, section: 1)
    }
  }

  let presenter: UINavigationController
  let dashboardViewController: DashboardViewController
  let dataProvider: DataProvider
  let settingsSuit: SettingsSuit
  private let awardManager: AwardsManager

  private var reviewCoordinator: ReviewCoordinator?

  init(dataProvider: DataProvider, presenter: UINavigationController, awardManager: AwardsManager, settingsSuit: SettingsSuit) {
    self.awardManager = awardManager
    self.dataProvider = dataProvider
    self.presenter = presenter
    self.settingsSuit = settingsSuit
    dashboardViewController = DashboardViewController.instantiateViewController()
    let tabItem: UITabBarItem = UITabBarItem(title: Constants.dashboardTitle, image: #imageLiteral(resourceName: "dashboard"), selectedImage: nil)
    presenter.tabBarItem = tabItem
  }

  func start() {
    dashboardViewController.delegate = self
    presenter.pushViewController(dashboardViewController, animated: false)
    _ = dashboardViewController.view
    fetchAllDashboardData()
  }

}

// MARK: - DashboardViewControllerDelegate
extension DashboardCoordinator {

  func dashboardPullToRefreshAction() {
    fetchAllDashboardData()
  }

  func didSelectCell(_ indexPath: IndexPath) {
    switch indexPath {
    case Constants.Path.lesson: showLessons()
    case Constants.Path.review: showReviews()
    default:
      break
    }
  }

  func showReviews() {
    reviewCoordinator = ReviewCoordinator(presenter: presenter, type: .review, settingsSuit: settingsSuit)
    reviewCoordinator?.delegate = self
    reviewCoordinator?.start()
  }

  func showLessons() {
    reviewCoordinator = ReviewCoordinator(presenter: presenter, type: .lesson, settingsSuit: settingsSuit)
    reviewCoordinator?.start()
  }

}

// MARK: - ReviewCoordinatorDelegate
extension DashboardCoordinator: ReviewCoordinatorDelegate {
    func reviewCompleted(_ coordinator: ReviewCoordinator, score: Int?) {
        guard let score = score else { return }
        awardManager.saveHighscore(scoreUpdate: score)
    }
}
