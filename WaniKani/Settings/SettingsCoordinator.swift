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
    let watchManager: WatchConnectivityManager
    fileprivate let awardManager: AwardsManager

    init(presenter: UINavigationController, awardManager: AwardsManager, settingsSuit: SettingsSuit, watchManager: WatchConnectivityManager) {
        self.watchManager = watchManager
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

    func showWatchSyncScreen() {
        let syncViewController: WatchSyncViewController = WatchSyncViewController.instantiateViewController()
        syncViewController.connectivityManager = watchManager
        presenter.pushViewController(syncViewController, animated: true)
    }

  func showPurchsesScreen() {
    let purchaseViewController: MasterViewController = MasterViewController.instantiateViewController()
    presenter.pushViewController(purchaseViewController, animated: true)
  }

}

// SettingsViewControllerDelegate
extension SettingsCoordinator {

    func cellPressed(_ indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (3, 3): self.delegate?.logOutPressed() //showPurchsesScreen()//
        case (3, 2): self.showWatchSyncScreen()
        case (3, 1): awardManager.showGameCenterViewController()
        default: break
        }
    }

    func cellCheckboxStateChange(identifier: String, state: Bool) {
        suit.changeSetting(identifier: identifier, state: state)
    }

}
