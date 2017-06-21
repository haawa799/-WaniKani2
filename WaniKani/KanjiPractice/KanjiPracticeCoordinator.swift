//
//  KanjiPracticeCoordinator.swift
//  WaniKani
//
//  Created by Andriy K. on 5/14/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class KanjiPracticeCoordinator: Coordinator {

  private let presenter: UINavigationController
  private let kanji: [String]
  private let kanjiPracticeViewController: KanjiPracticeViewController = KanjiPracticeViewController.instantiateViewController()

  init(presenter: UINavigationController, kanji: [String]) {
    presenter.isNavigationBarHidden = true
    self.kanji = kanji
    self.presenter = presenter
  }

}

// MARK: - Coordinator
extension KanjiPracticeCoordinator {
  func start() {
    kanjiPracticeViewController.kanjiStrings = kanji
    presenter.pushViewController(kanjiPracticeViewController, animated: false)
  }
}
