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
import WaniKit
import PersistanceLayer

class ApplicationCoordinator: Coordinator {

  fileprivate var tabsCoordinator: TabsCoordinator?
  fileprivate let waniLoginCoordinator: WaniLoginCoordinator
  fileprivate let persistance = Persistance()
  var fetcher: WaniKitManager?

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
    fetcher = WaniKitManager(apiKey: apiKey)

    fetcher?.fetchUserInfo().then { self.persistance.persist(userInfo: $0) }
    fetcher?.fetchStudyQueue().then { self.persistance.persist(studyQueue: $0) }
    fetcher?.fetchSRS().then { self.persistance.persist(srs: $0) }

    presentTabs(apiKey: apiKey)
    CookiesStorage.saveCookies()
  }

}
