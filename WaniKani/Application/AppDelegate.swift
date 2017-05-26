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

}
