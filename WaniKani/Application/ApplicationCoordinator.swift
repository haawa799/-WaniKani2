//✅
//  ApplicationCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import WaniLoginKit
import Cely

class ApplicationCoordinator: Coordinator {

  fileprivate var tabsCoordinator: TabsCoordinator?
  fileprivate let waniLoginCoordinator: WaniLoginCoordinator

  let window: UIWindow
  let rootViewController = ColorfullTabBarController()

  init(window: UIWindow) {
    self.window = window
    waniLoginCoordinator = WaniLoginCoordinator()
  }

  func presentTabs(apiKey: String) {
    window.rootViewController = rootViewController
    let dataProvider = DataProvider(apiKey: apiKey)
    let tabsCoordinator = TabsCoordinator(dataProvider: dataProvider, presenter: rootViewController)
    tabsCoordinator.start()
    self.tabsCoordinator = tabsCoordinator
  }

}

// MARK: - Coordinator
extension ApplicationCoordinator: CelyWindowManagerDelegate {
  func start() {
    window.rootViewController = rootViewController
    waniLoginCoordinator.start(delegate: self, window: window)
    window.makeKeyAndVisible()
  }

  var shouldTryUsingMainStoryboard: Bool {
    return false
  }

  func presentingCallback(window: UIWindow, status: CelyStatus) {
    guard status == .loggedIn else { return }
    guard let apiKey = waniLoginCoordinator.apiKey else { return }
    presentTabs(apiKey: apiKey)
    CookiesStorage.saveCookies()
  }

}
