//✅
//  AppDelegate.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  fileprivate lazy var applicationCoordinator: ApplicationCoordinator = {
    return ApplicationCoordinator(window: self.window!)
  }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    applicationCoordinator.start()
    return true
  }

  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    applicationCoordinator.doBackgroundFetch(completionHandler: completionHandler)
  }

  @available(iOS 9.0, *)
  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    completionHandler(handleShortcut(shortcutItem: shortcutItem))
  }

  @available(iOS 9.0, *)
  private func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {
    guard let shortcut = ShortcutIdentifier(string: shortcutItem.type) else { return false }
    applicationCoordinator.handelShortCut(shortcut: shortcut)
    return true
  }

}
