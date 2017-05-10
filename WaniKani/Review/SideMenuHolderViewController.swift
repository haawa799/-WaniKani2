//
//  SideMenuViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 12/30/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit
import RESideMenuKit

protocol SideMenuHolderViewControllerDelegate: class {
  func didShowMenu()
  func didColapseMenu()
}

class SideMenuHolderViewController: RESideMenu {

  var type: WebSessionType?
  weak var menuDelegate: SideMenuHolderViewControllerDelegate?

  convenience init(type: WebSessionType, settingsSuit: SettingsSuit?) {

    let q = UIViewController()
    q.view.backgroundColor = UIColor.cyan

    let middleViewController = ReviewWebViewController(nibName: ReviewWebViewController.defaultFileName, bundle: nil, settingsSuit: settingsSuit)
    let rightViewController = RightMenuViewController(contentViewController: q)
    _ = rightViewController.view

    self.init()

    self.type = type
    self.rightMenuViewController = rightViewController
    self.contentViewController = middleViewController
  }

  override func viewDidLoad() {

    delegate = self
    (contentViewController as? ReviewWebViewController)?.delegate = self

    super.viewDidLoad()

    backgroundImage = UIImage(named: "strokes_bg")
    contentViewController.view.backgroundColor = UIColor.clear
    view.clipsToBounds = true

  }

  func dumpAnimation() {

    let deltaX: CGFloat = -40
    let animationDuration: TimeInterval = 0.5
    let holdDuration: TimeInterval = 0.3
    let springDamping: CGFloat = 1.0

    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
      self.contentViewController.view.transform = CGAffineTransform(translationX: deltaX, y: 0)
      }, completion: { (_) -> Void in
        DispatchQueue.main.asyncAfter(deadline: .now() + holdDuration) {
          UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.contentViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
          })
        }
    })
  }
}

extension SideMenuHolderViewController: RESideMenuDelegate {

  func sideMenu(_ sideMenu: RESideMenu!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!) {

  }
  func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {

  }
  func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {

  }
  func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {

  }
  func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
    menuDelegate?.didColapseMenu()
  }

}

extension SideMenuHolderViewController {

  override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return true
  }
}

extension SideMenuHolderViewController: ReviewWebViewControllerDelegate {

  func webViewControllerBecomeReadyForLoad(viewController: ReviewWebViewController) {
    guard let type = type else { return }
    viewController.loadReviews(type)
  }
}
