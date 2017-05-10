//
//  StatusBarTweeks.swift
//  WaniKani
//
//  Created by Andriy K. on 1/27/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

extension UIViewController {

  private var statusBarWindow: UIWindow? {
    return UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
  }

  func setStatusBarAlpha(alpha: CGFloat) {
    statusBarWindow?.alpha = alpha
  }

}
