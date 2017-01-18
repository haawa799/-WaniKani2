//✅
//  ApplicationCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

open class ApplicationCoordinator: Coordinator {

  fileprivate let applicationSettingsSuit = SettingsSuit(userDefaults: UserDefaults.standard)
  fileprivate let dashboardNavigationController = UINavigationController()
  fileprivate let dashboardCoordinator: DashboardCoordinator
  fileprivate let settingsNavigationController = UINavigationController()
  fileprivate let settingsCoordinator: SettingsCoordinator

  let window: UIWindow
  let rootViewController = ColorfullTabBarController()
  let childrenCoordinators: [Coordinator]

  init(window: UIWindow) {
    self.window = window
    dashboardNavigationController.isNavigationBarHidden = true
    settingsNavigationController.isNavigationBarHidden = true
    let viewControllers = [dashboardNavigationController, settingsNavigationController]
    rootViewController.setViewControllers(viewControllers, animated: false)
    dashboardCoordinator = DashboardCoordinator(presenter: dashboardNavigationController)
    settingsCoordinator = SettingsCoordinator(presenter: settingsNavigationController, settingsSuit: applicationSettingsSuit)
    childrenCoordinators = [dashboardCoordinator, settingsCoordinator]
  }
}

// MARK: - Coordinator
extension ApplicationCoordinator {
  func start() {
//    DataProvider.makeInitialPreperations()
    window.rootViewController = rootViewController
    dashboardCoordinator.start()
    settingsCoordinator.start()
    window.makeKeyAndVisible()
  }
}
