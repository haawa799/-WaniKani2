//
//  SettingsCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

protocol SettingsCoordinatorDelegate: class {
    func logOutPressed()
}

class SettingsCoordinator: Coordinator, SettingsViewControllerDelegate {

    weak var delegate: SettingsCoordinatorDelegate?

  let presenter: UINavigationController
  let settingsViewController: SettingsViewController
  let childrenCoordinators: [Coordinator]
  let suit: SettingsSuit
  fileprivate let awardManager: AwardsManager

//  let dataProvider = DataProvider()

  init(presenter: UINavigationController, awardManager: AwardsManager, settingsSuit: SettingsSuit) {
    self.presenter = presenter
    self.awardManager = awardManager
    suit = settingsSuit
    settingsViewController = SettingsViewController.instantiateViewController()
    let tabItem: UITabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
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
    switch (indexPath.section, indexPath.row) {
        case (3, 2): delegate?.logOutPressed()
        case (3, 1): awardManager.showGameCenterViewController()
        default: break
    }
  }

  func cellCheckboxStateChange(identifier: String, state: Bool) {
    suit.changeSetting(identifier: identifier, state: state)
  }

}
