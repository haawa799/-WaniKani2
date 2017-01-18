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
  func leftButtonPressed()
  func rightButtonPressed()
  func focusShortcutUsed()
}

class BottomBarContainerViewController: UIViewController, StoryboardInstantiable {

  @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var toolBar: UIToolbar!

  weak var delegate: BottomBarContainerDelegate?

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
  }

  override var prefersStatusBarHidden: Bool {
    return false
  }

}

// MARK: - Actions
extension BottomBarContainerViewController {

  @IBAction func leftButtonPressed(_ sender: UIBarButtonItem) {
    delegate?.leftButtonPressed()
  }

  @IBAction func rightButtonPressed(_ sender: UIBarButtonItem) {
    delegate?.rightButtonPressed()
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
    delegate?.leftButtonPressed()
  }

  func leftArrowPressed(_ sender: UIKeyCommand) {
    delegate?.rightButtonPressed()
  }

  func focusPressed(_ sender: UIKeyCommand) {
    delegate?.focusShortcutUsed()
  }
}
