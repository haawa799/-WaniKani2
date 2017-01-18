//
//  ReviewCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 4/1/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

public protocol ReviewCoordinatorDelegate: class {
  func reviewCompleted(_ coordinator: ReviewCoordinator)
}

open class ReviewCoordinator: NSObject, Coordinator, BottomBarContainerDelegate {

  let presenter: UINavigationController
  let containerViewController: BottomBarContainerViewController
  let sideMenuController: SideMenuHolderViewController

  let childrenCoordinators: [Coordinator]

//  let dataProvider = DataProvider()

  fileprivate var sideMenuVisible = false

  weak var delegate: ReviewCoordinatorDelegate?

  public init(presenter: UINavigationController, type: WebSessionType) {
    self.presenter = presenter
    containerViewController = BottomBarContainerViewController.instantiateViewController()
    sideMenuController = SideMenuHolderViewController(type: .review, settingsSuit: nil)
    childrenCoordinators = []
  }

  func start() {
    containerViewController.delegate = self
    sideMenuController.delegate = self
    presenter.modalPresentationCapturesStatusBarAppearance = true
    presenter.present(containerViewController, animated: true, completion: nil)
    containerViewController.childViewController = sideMenuController
  }

}

public extension ReviewCoordinator {
  func leftButtonPressed() {
    presenter.dismiss(animated: true) {
      self.delegate?.reviewCompleted(self)
    }
  }

  func rightButtonPressed() {
    if sideMenuVisible == true {
      sideMenuController.hideViewController()
      sideMenuVisible = false
      showBar()
    } else {
      sideMenuController.presentRightMenuViewController()
      sideMenuVisible = true
      hideBar()
    }

  }
}

public extension ReviewCoordinator {

  func hideBar() {
    containerViewController.hideBar()
  }

  func showBar() {
    containerViewController.showBar()
  }

  func focusShortcutUsed() {
//    sideMenuController.focus()
  }

}
