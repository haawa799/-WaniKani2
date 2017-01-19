//✅
//  TabsCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

open class TabsCoordinator: Coordinator {

  fileprivate let applicationSettingsSuit = SettingsSuit(userDefaults: UserDefaults.standard)
  fileprivate let dashboardNavigationController = UINavigationController()
  fileprivate let dashboardCoordinator: DashboardCoordinator
  fileprivate let settingsNavigationController = UINavigationController()
  fileprivate let settingsCoordinator: SettingsCoordinator

  let childrenCoordinators: [Coordinator]
  let presenter: UITabBarController
  let dataProvider: DataProvider

  init(dataProvider: DataProvider, presenter: UITabBarController) {
    self.dataProvider = dataProvider
    self.presenter = presenter
    dashboardNavigationController.isNavigationBarHidden = true
    settingsNavigationController.isNavigationBarHidden = true
    let viewControllers = [dashboardNavigationController, settingsNavigationController]
    presenter.setViewControllers(viewControllers, animated: false)
    dashboardCoordinator = DashboardCoordinator(dataProvider: dataProvider, presenter: dashboardNavigationController)
    settingsCoordinator = SettingsCoordinator(presenter: settingsNavigationController, settingsSuit: applicationSettingsSuit)
    childrenCoordinators = [dashboardCoordinator, settingsCoordinator]
  }

}

// MARK: - Coordinator
extension TabsCoordinator {
  func start() {
    dashboardCoordinator.start()
    settingsCoordinator.start()
  }

}
