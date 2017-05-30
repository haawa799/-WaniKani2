//
//  DownloadingViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 5/29/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class DownloadingViewController: UIViewController, StoryboardInstantiable, BluredBackground {

  @IBOutlet weak var progressView: UIProgressView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  @IBOutlet weak var startDownloading: UIButton?

  var isDownloading = false {
    didSet {
      switch isDownloading {
      case true:
        activityIndicator?.isHidden = false
        startDownloading?.isHidden = true
      case false:
        activityIndicator?.isHidden = true
        startDownloading?.isHidden = false
      }
    }
  }

}

// MARK: - UIViewController
extension DownloadingViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    _ = addBackground(BackgroundOptions.data.rawValue)
  }
}
