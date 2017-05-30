//
//  DownloadingCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 5/29/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class DownloadingCoordinator: Coordinator {
  let presenter: UINavigationController
  let downloadViewController: DownloadingViewController = DownloadingViewController.instantiateViewController()

  init(presenter: UINavigationController) {
    self.presenter = presenter
  }

  func start() {
    presenter.setViewControllers([downloadViewController], animated: false)
  }
}
