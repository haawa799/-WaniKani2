//
//  SettingsCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

open class SettingsCoordinator: Coordinator, SettingsViewControllerDelegate {

  let presenter: UINavigationController
  let settingsViewController: SettingsViewController
  let childrenCoordinators: [Coordinator]
  let suit: SettingsSuit

//  let dataProvider = DataProvider()

  public init(presenter: UINavigationController, settingsSuit: SettingsSuit) {
    self.presenter = presenter
    suit = settingsSuit
    settingsViewController = SettingsViewController.instantiateViewController()
    let tabItem: UITabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: nil)
    presenter.tabBarItem = tabItem
    childrenCoordinators = []
  }

  func start() {
    presenter.pushViewController(settingsViewController, animated: false)
    settingsViewController.delegate = self
    settingsViewController.settingSuit = suit
  }

}

// SettingsViewControllerDelegate
extension SettingsCoordinator {

  func cellPressed(_ indexPath: IndexPath) {
    print("indexPath: \(indexPath)")
  }

  func cellCheckboxStateChange(identifier: String, state: Bool) {
    suit.changeSetting(identifier: identifier, state: state)
  }

}
