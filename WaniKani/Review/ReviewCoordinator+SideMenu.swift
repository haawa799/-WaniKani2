//
//  ReviewCoordinator+SideMenu.swift
//  WaniKani
//
//  Created by Andriy K. on 4/10/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

extension ReviewCoordinator: RESideMenuDelegate {

  @objc public func sideMenu(_ sideMenu: RESideMenu!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!) {

  }

  @objc public func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
    hideBar()
  }

  @objc public func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {

  }

  @objc public func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {

  }

  @objc public func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
    showBar()
  }

}
