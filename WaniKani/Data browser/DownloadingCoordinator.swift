//
//  DownloadingCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 5/29/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

protocol DownloadingCoordinatorDelegate: class {
  func downloadComplete()
}

class DownloadingCoordinator: Coordinator {

  weak var delegate: DownloadingCoordinatorDelegate?
  let syncQueue = DispatchQueue(label: "Syncer queue")

  fileprivate let presenter: UINavigationController
  fileprivate let dataProvider: DataProvider
  fileprivate let downloadViewController: DownloadingViewController = DownloadingViewController.instantiateViewController()

  init(presenter: UINavigationController, dataProvider: DataProvider) {
    self.presenter = presenter
    self.dataProvider = dataProvider
  }

  func start() {
    downloadViewController.delegate = self
    presenter.setViewControllers([downloadViewController], animated: false)
  }
}

// MARK: - DownloadingViewControllerDelegate
extension DownloadingCoordinator: DownloadingViewControllerDelegate {
  func startDownloadPressed() {
    downloadViewController.maxProgress = 60 * 3
    downloadViewController.currentProgress = 0

    dataProvider.fetchRadicals { [weak self] (success) in
      switch success {
      case true: debugPrint("radicals"); self?.incrementProgress()
      case false: self?.cancelDownload()
      }
    }

    dataProvider.fetchKanji { [weak self] (success) in
      switch success {
      case true: debugPrint("kanji"); self?.incrementProgress()
      case false: self?.cancelDownload()
      }
    }

    dataProvider.fetchWords { [weak self] (success) in
      switch success {
      case true: debugPrint("words"); self?.incrementProgress()
      case false: self?.cancelDownload()
      }
    }
  }

  func progress100Percent() {
    delegate?.downloadComplete()
  }

  func cancelDownload() {

  }

  func incrementProgress() {
    syncQueue.sync { [weak self] in
      self?.downloadViewController.currentProgress += 1
    }
  }
}
