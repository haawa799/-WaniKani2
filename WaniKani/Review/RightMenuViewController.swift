//
//  RightMenuViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 9/27/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit

class RightMenuViewController: UIViewController, StoryboardInstantiable  {
  
  @IBOutlet weak var containerView: UIView?
//  @IBOutlet weak var leadingConstraint: NSLayoutConstraint?
  private var embadedViewControllerIsSet = false
  
  private var containerViewController: UIViewController? {
    didSet {
      addEmbadedViewControllerIfNeeded()
    }
  }
  
  convenience init(contentViewController: UIViewController) {
    self.init(nibName: RightMenuViewController.defaultFileName, bundle: nil)
    containerViewController = contentViewController
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addEmbadedViewControllerIfNeeded()
  }
  
  private func addEmbadedViewControllerIfNeeded() {
    guard embadedViewControllerIsSet == false else { return }
    guard let containerView = containerView else { return }
    guard let containerViewController = containerViewController else { return }
    addChildViewController(containerViewController)
    containerViewController.view.frame = containerView.bounds
    containerView.addSubview(containerViewController.view)
    containerViewController.didMove(toParentViewController: self)
    embadedViewControllerIsSet = true
  }
  
}
