//
//  KanjiDetailViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/25/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

class KanjiDetailViewController: UIViewController, BluredBackground, StoryboardInstantiable {
    @IBOutlet weak var levelKanji: UILabel? {
        didSet {
            guard let level = kanji?.level else { return }
            levelKanji?.text = "\(level)"
        }
    }

    @IBOutlet weak var meaningLabel: UILabel? {
        didSet {
            meaningLabel?.text = kanji?.meaning
        }
    }

    @IBOutlet weak var srsLabel: UILabel? {
        didSet {
            srsLabel?.text = kanji?.userSpecific?.srs
        }
    }

    var kanji: KanjiInfo? {
        didSet {
            guard let kanji = kanji else { return }
            meaningLabel?.text = kanji.meaning
            kanjiStrings = [kanji.character]
        }
    }

    fileprivate var kanjiStrings = [String]() {
        didSet {
            updateStrokeOrderViewController()
        }
    }
    var strokeOrderViewController: StrokeOrderViewController? {
        didSet {
            updateStrokeOrderViewController()
        }
    }

    @IBOutlet weak var strokeOrderContainer: UIView? {
        didSet {
            guard let strokeOrderContainer = strokeOrderContainer else { return }
            let strokeOrderViewController: StrokeOrderViewController = StrokeOrderViewController.instantiateViewController()
            addChildViewController(strokeOrderViewController)
            strokeOrderContainer.addSubview(strokeOrderViewController.view)
            strokeOrderViewController.view.frame = strokeOrderContainer.bounds
            strokeOrderViewController.view.translatesAutoresizingMaskIntoConstraints = true
            self.strokeOrderViewController = strokeOrderViewController
        }
    }

    fileprivate func updateStrokeOrderViewController() {
        strokeOrderViewController?.kanjiStrings = self.kanjiStrings
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = addBackground(BackgroundOptions.data.rawValue)
    }

}
