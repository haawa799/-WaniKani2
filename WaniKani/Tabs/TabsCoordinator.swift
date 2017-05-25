//✅
//  TabsCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import WaniPersistance

open class TabsCoordinator: Coordinator {

  fileprivate let applicationSettingsSuit = SettingsSuit(userDefaults: UserDefaults.standard)
  fileprivate let dashboardNavigationController = UINavigationController()
  fileprivate let dashboardCoordinator: DashboardCoordinator
  fileprivate let settingsNavigationController = UINavigationController()
  fileprivate let settingsCoordinator: SettingsCoordinator
  fileprivate let dataBrowserNavigationController = UINavigationController()
  fileprivate let dataBrowserCoordinator: DataBrowserCoordinator

  let presenter: UITabBarController
  let dataProvider: DataProvider

  init(dataProvider: DataProvider, presenter: UITabBarController, persistance: Persistance) {
    self.dataProvider = dataProvider
    self.presenter = presenter
    dashboardNavigationController.isNavigationBarHidden = true
    settingsNavigationController.isNavigationBarHidden = true
    let viewControllers = [dashboardNavigationController, dataBrowserNavigationController, settingsNavigationController]
    presenter.setViewControllers(viewControllers, animated: false)
    dashboardCoordinator = DashboardCoordinator(dataProvider: dataProvider, presenter: dashboardNavigationController, settingsSuit: applicationSettingsSuit)
    settingsCoordinator = SettingsCoordinator(presenter: settingsNavigationController, settingsSuit: applicationSettingsSuit)
    dataBrowserCoordinator = DataBrowserCoordinator(presenter: dataBrowserNavigationController, persistance: persistance)
  }

}

// MARK: - Coordinator
extension TabsCoordinator {
  func start() {
    dashboardCoordinator.start()
    settingsCoordinator.start()
    dataBrowserCoordinator.start()
  }

}
