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

class ReviewCoordinator: NSObject, Coordinator, BottomBarContainerDelegate, BottomBarContainerDataSource {

  let presenter: UINavigationController
  let containerViewController: BottomBarContainerViewController
  let sideMenuController: SideMenuHolderViewController

  let childrenCoordinators: [Coordinator]

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
    containerViewController.dataSource = self
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
    switch index {
    case 0: leftButtonPressed()
    case 2: rightButtonPressed()
    default: break
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

// MARK: - BottomBarContainerDataSource
extension ReviewCoordinator {
  func itemForIndex(index: Int) -> BarItemData {
    switch index {
    case 0: return BarItemData.item(title: "Submit To GC")
    case 2: return BarItemData.item(title: "StrokesSSSsss")
    default: return BarItemData.spacing
    }
  }

  func numberOfItems() -> Int {
    return 3
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
