//
//  StrokeOrderCoordinator.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class StrokeOrderCoordinator: Coordinator {

    private let strokesViewController: StrokeOrderViewController
    private let presenter: UIViewController
    private let kanji: [String]

    init(presenter: UIViewController, kanji: [String]) {
        self.kanji = kanji
        self.presenter = presenter
        self.strokesViewController = StrokeOrderViewController.instantiateViewController()
    }

}

// MARK: - Coordinator
extension StrokeOrderCoordinator {
    func start() {
        strokesViewController.kanjiStrings = kanji
        presenter.view.addSubview(strokesViewController.view)
        presenter.addChildViewController(strokesViewController)
    }
}
