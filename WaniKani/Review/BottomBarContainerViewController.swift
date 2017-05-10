//
//  SideMenuContainerController.swift
//  WaniKani
//
//  Created by Andriy K. on 1/5/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit
import NJKScrollFullscreenKit

protocol BottomBarContainerDelegate: class {
  func toolBarItemPressed(index: Int)
  func focusShortcutUsed()
}

protocol BottomBarContainerDataSource {
  func itemForIndex(index: Int) -> BarItemData
  /// This includes spaceing items
  func numberOfItems() -> Int
}

enum BarItemData {
  case item(title: String)
  case spacing
}

class BottomBarContainerViewController: UIViewController, StoryboardInstantiable {

  @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var toolBar: UIToolbar!

  weak var delegate: BottomBarContainerDelegate?
  var dataSource: BottomBarContainerDataSource? {
    didSet {
      guard let dataSource = dataSource else { return }
      reloadToolBarItems(dataSource: dataSource)
    }
  }

  fileprivate func reloadToolBarItems(dataSource: BottomBarContainerDataSource) {
    var items = [UIBarButtonItem]()
    for index in 0..<dataSource.numberOfItems() {
      let item: UIBarButtonItem
      let data = dataSource.itemForIndex(index: index)
      switch data {
      case .item(let title): item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(toolBarItemsAction(_:)))
      case .spacing: item = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      }
      item.tag = index
      items.append(item)
    }
    toolBar?.items = items
  }

  var childViewController: UIViewController? {
    didSet {
      guard let childViewController = childViewController else { return }
      childViewController.view.frame = containerView.bounds
      addChildViewController(childViewController)
      containerView.addSubview(childViewController.view)
    }
  }

}

// MARK: - UIViewController
extension BottomBarContainerViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.showToolbar(false)
    guard let dataSource = dataSource else { return }
    reloadToolBarItems(dataSource: dataSource)
  }

  override var prefersStatusBarHidden: Bool {
    return false
  }

}

// MARK: - Actions
extension BottomBarContainerViewController {

  func toolBarItemsAction(_ sender: UIBarButtonItem) {
    let index = sender.tag
    delegate?.toolBarItemPressed(index: index)
  }

}

// MARK: - Show hide bottom bar
extension BottomBarContainerViewController {

  func showBar() {
  }

  func hideBar() {
  }

  override var keyCommands: [UIKeyCommand]? {
    if #available(iOS 9.0, *) {
      return [
        UIKeyCommand(input: UIKeyInputEscape, modifierFlags: .command, action: #selector(escapePressed(_:)), discoverabilityTitle: "End session"),
        UIKeyCommand(input: UIKeyInputLeftArrow, modifierFlags: .command, action: #selector(leftArrowPressed(_:)), discoverabilityTitle: "Stroke order"),
        UIKeyCommand(input: UIKeyInputUpArrow, modifierFlags: .alternate, action: #selector(focusPressed(_:)), discoverabilityTitle: "Focus textfield")
      ]
    } else {
      // Fallback on earlier versions
      return [
        UIKeyCommand(input: UIKeyInputEscape, modifierFlags: .command, action: #selector(escapePressed(_:)))
      ]
    }
  }

  func escapePressed(_ sender: UIKeyCommand) {
    // delegate?.leftButtonPressed()
  }

  func leftArrowPressed(_ sender: UIKeyCommand) {
    // delegate?.rightButtonPressed()
  }

  func focusPressed(_ sender: UIKeyCommand) {
    delegate?.focusShortcutUsed()
  }
}
