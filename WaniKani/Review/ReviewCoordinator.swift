//
//  ReviewCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 4/1/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

protocol ReviewCoordinatorDelegate: class {
  func reviewCompleted(_ coordinator: ReviewCoordinator)
}

class ReviewCoordinator: NSObject, Coordinator, BottomBarContainerDelegate {

  let presenter: UINavigationController
  let containerViewController: BottomBarContainerViewController
  let sideMenuController: SideMenuHolderViewController
  let type: WebSessionType

  let childrenCoordinators: [Coordinator]

  fileprivate var sideMenuVisible = false

  weak var delegate: ReviewCoordinatorDelegate?

  public init(presenter: UINavigationController, type: WebSessionType, settingsSuit: SettingsSuit?) {
    self.presenter = presenter
    self.type = type
    containerViewController = BottomBarContainerViewController.instantiateViewController()
    sideMenuController = SideMenuHolderViewController(type: type, settingsSuit: settingsSuit)
    childrenCoordinators = []
  }

  func start() {
    containerViewController.delegate = self
    containerViewController.dataSource = type
    sideMenuController.delegate = self
    presenter.modalPresentationCapturesStatusBarAppearance = true
    presenter.present(containerViewController, animated: true, completion: nil)
    containerViewController.childViewController = sideMenuController
    sideMenuController.didMove(toParentViewController: containerViewController)
  }

}

// MARK: - BottomBarContainerDelegate
extension ReviewCoordinator {

  func toolBarItemPressed(index: Int) {
    let action = type.barActionForIndex(index: index)
    switch action {
      case .finish, .submitToGameCenter: leftButtonPressed()
      case .strokes: rightButtonPressed()
    }
  }

  func focusShortcutUsed() {
  }

  private func leftButtonPressed() {
    presenter.dismiss(animated: true) {
      self.delegate?.reviewCompleted(self)
    }
  }

  private func rightButtonPressed() {
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

extension ReviewCoordinator {

  func hideBar() {
    containerViewController.hideBar()
  }

  func showBar() {
    containerViewController.showBar()
  }

}
