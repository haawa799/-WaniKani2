//
//  DownloadingViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 5/29/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

protocol DownloadingViewControllerDelegate: class {
  func startDownloadPressed()
  func progress100Percent()
}

class DownloadingViewController: UIViewController, StoryboardInstantiable, BluredBackground {

  weak var delegate: DownloadingViewControllerDelegate?

  var maxProgress = 0
  var currentProgress = 0 {
    didSet {
      if currentProgress == maxProgress {
        isDownloading = false
        delegate?.progress100Percent()
      }
      let progress = Float(currentProgress) / Float(maxProgress)
      DispatchQueue.main.async { [weak self] in
        self?.progressView?.progress = progress
      }
    }
  }
  @IBAction func downloadAction(_ sender: Any) {
    isDownloading = true
    delegate?.startDownloadPressed()
  }

  @IBOutlet weak var progressView: UIProgressView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  @IBOutlet weak var startDownloading: UIButton?

  var isDownloading = false {
    didSet {
      switch isDownloading {
      case true:
        activityIndicator?.startAnimating()
        startDownloading?.isHidden = true
      case false:
        activityIndicator?.stopAnimating()
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
