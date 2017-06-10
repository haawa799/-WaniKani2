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
  let awardManager: AwardsManager

  init(window: UIWindow) {
    self.window = window
    waniLoginCoordinator = WaniLoginCoordinator()
    self.awardManager = AwardsManager(presenter: rootViewController)
  }

    func presentTabs(apiKey: String, userName: String, password: String, persistance: Persistance) {
    window.rootViewController = rootViewController
    let dataProvider = DataProvider(apiKey: apiKey, persistance: persistance)
    dataProvider.delegate = self
    let tabsCoordinator = TabsCoordinator(dataProvider: dataProvider, awardManager: awardManager, presenter: rootViewController, persistance: persistance, apiKey: apiKey, userName: userName, pasword: password)
    tabsCoordinator.delegate = self
    tabsCoordinator.start()
    self.tabsCoordinator = tabsCoordinator
    awardManager.authenticateLocalPlayer()
  }

  func displayLogoutPrompt() {
    let alertController = UIAlertController(title: "Do you want to log out?", message:
      nil, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { [weak self] (_) in
      self?.logout()
    }))
    self.rootViewController.present(alertController, animated: true, completion: nil)
  }

  fileprivate func logout() {
    // Remove all cache
    if let oldCookies = HTTPCookieStorage.shared.cookies {
        debugPrint(oldCookies)
        for oldCookie in oldCookies {
            HTTPCookieStorage.shared.deleteCookie(oldCookie)
        }
    }
    Defaults.nuke()
    waniLoginCoordinator.logOut()
  }

}

// MARK: - CelyWindowManagerDelegate
extension ApplicationCoordinator: CelyWindowManagerDelegate {
  func start() {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
//      UNUserNotificationCenter.current().requestAuthorization(
//        options: [.alert, .sound, .badge],
//        completionHandler: { (_, _) in
//      })
    }
    window.rootViewController = rootViewController
    waniLoginCoordinator.start(delegate: self, window: window)
    window.makeKeyAndVisible()
  }

  var shouldTryUsingMainStoryboard: Bool {
    return false
  }

  func presentingCallback(window: UIWindow, status: CelyStatus) {
    guard status == .loggedIn else { return }
    guard let apiKey = waniLoginCoordinator.apiKey, let userName = waniLoginCoordinator.userName, let password = waniLoginCoordinator.password else { return }
    let fm = FileManager.default
    let docsurl = try? fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let persistance = Persistance(setupInMemory: false, apiKey: apiKey, folderUrl: docsurl)
    fetcher = WaniKitManager(apiKey: apiKey)
    presentTabs(apiKey: apiKey, userName: userName, password: password, persistance: persistance)
  }

  func handelShortCut(shortcut: ShortcutIdentifier) {
    switch shortcut {
    case .reviews: tabsCoordinator?.showReviews()
    case .lessons: tabsCoordinator?.showLessons()
    }
  }

}

// MARK: - DataProviderDelegate
extension ApplicationCoordinator: DataProviderDelegate {
  func apiKeyIncorect() {
    guard waniLoginCoordinator.isLoggedIn == true else { return }
    let alertController = UIAlertController(title: "Network request failed", message:
      "This might mean that API key has changed. If this error repeats you might need to login again.", preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
    alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { [weak self] (_) in
      self?.logout()
    }))

    self.rootViewController.present(alertController, animated: true, completion: nil)
  }
  func userDidLevelUp(oldLevel: Int, newLevel: Int) {
    awardManager.userLevelUp(oldLevel: oldLevel, newLevel: newLevel)
  }
}

// MARK: - UNUserNotificationCenterDelegate
@available(iOS 10.0, *)
extension ApplicationCoordinator: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    debugPrint(response.actionIdentifier)
    if response.actionIdentifier == "CancelIdentifier" {
      window.rootViewController = nil
    }
  }
}

// MARK: - TabsCoordinatorDelegate
extension ApplicationCoordinator: TabsCoordinatorDelegate {
    func logOutPressed() {
        displayLogoutPrompt()
    }
}
