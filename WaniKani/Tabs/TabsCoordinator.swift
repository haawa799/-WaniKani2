//✅
//  TabsCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import WaniPersistance

protocol TabsCoordinatorDelegate: class {
    func logOutPressed()
}

open class TabsCoordinator: Coordinator {

    weak var delegate: TabsCoordinatorDelegate?

  fileprivate let applicationSettingsSuit = SettingsSuit(userDefaults: UserDefaults.standard)
  fileprivate let dashboardNavigationController = UINavigationController()
  fileprivate let dashboardCoordinator: DashboardCoordinator
  fileprivate let settingsNavigationController = UINavigationController()
  fileprivate let settingsCoordinator: SettingsCoordinator
  fileprivate let dataBrowserNavigationController = UINavigationController()
  fileprivate let dataBrowserCoordinator: DataBrowserCoordinator
  fileprivate let awardManager: AwardsManager

  let presenter: UITabBarController
  let dataProvider: DataProvider

  init(dataProvider: DataProvider, awardManager: AwardsManager, presenter: UITabBarController, persistance: Persistance) {
    self.dataProvider = dataProvider
    self.awardManager = awardManager
    self.presenter = presenter
    dashboardNavigationController.isNavigationBarHidden = true
    settingsNavigationController.isNavigationBarHidden = true
    let viewControllers = [dashboardNavigationController, dataBrowserNavigationController, settingsNavigationController]
    presenter.setViewControllers(viewControllers, animated: false)
    dashboardCoordinator = DashboardCoordinator(dataProvider: dataProvider, presenter: dashboardNavigationController, awardManager: awardManager, settingsSuit: applicationSettingsSuit)
    settingsCoordinator = SettingsCoordinator(presenter: settingsNavigationController, awardManager: awardManager, settingsSuit: applicationSettingsSuit)
    dataBrowserCoordinator = DataBrowserCoordinator(presenter: dataBrowserNavigationController, persistance: persistance, dataProvider: dataProvider)
  }

    func showLessons() {
        presenter.selectedIndex = 0
        dashboardCoordinator.showLessons()
    }

    func showReviews() {
        presenter.selectedIndex = 0
        dashboardCoordinator.showReviews()
    }

}

// MARK: - Coordinator
extension TabsCoordinator {
  func start() {
    settingsCoordinator.delegate = self
    dashboardCoordinator.start()
    settingsCoordinator.start()
    dataBrowserCoordinator.start()
  }

}

// MARK: - SettingsCoordinatorDelegate
extension TabsCoordinator: SettingsCoordinatorDelegate {
    func logOutPressed() {
        delegate?.logOutPressed()
    }
}
