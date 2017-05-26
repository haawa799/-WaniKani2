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
import WaniPersistance
import UserNotifications

class ApplicationCoordinator: NSObject, Coordinator {

  fileprivate var tabsCoordinator: TabsCoordinator?
  fileprivate let waniLoginCoordinator: WaniLoginCoordinator
  fileprivate var persistance: Persistance!
  var fetcher: WaniKitManager?

  let window: UIWindow
  let rootViewController = ColorfullTabBarController()

  init(window: UIWindow) {
    self.window = window
    waniLoginCoordinator = WaniLoginCoordinator()
  }

  func presentTabs(apiKey: String, persistance: Persistance) {
    window.rootViewController = rootViewController
    let dataProvider = DataProvider(apiKey: apiKey, persistance: persistance)
    dataProvider.delegate = self
    let tabsCoordinator = TabsCoordinator(dataProvider: dataProvider, presenter: rootViewController, persistance: persistance)
    tabsCoordinator.start()
    self.tabsCoordinator = tabsCoordinator
  }

}

// MARK: - Coordinator
extension ApplicationCoordinator: CelyWindowManagerDelegate {
  func start() {
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .sound, .badge],
        completionHandler: { (_, _) in
    })
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
    let fm = FileManager.default
    let docsurl = try? fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let persistance = Persistance(setupInMemory: false, apiKey: apiKey, folderUrl: docsurl)
    fetcher = WaniKitManager(apiKey: apiKey)
    presentTabs(apiKey: apiKey, persistance: persistance)
    CookiesStorage.saveCookies()
  }

}

// MARK: - DataProviderDelegate
extension ApplicationCoordinator: DataProviderDelegate {
    func apiKeyIncorect() {
        guard waniLoginCoordinator.isLoggedIn == true else { return }
        waniLoginCoordinator.logOut()
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension ApplicationCoordinator: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint(response.actionIdentifier)
        if response.actionIdentifier == "CancelIdentifier" {
            window.rootViewController = nil
        }
    }
}
