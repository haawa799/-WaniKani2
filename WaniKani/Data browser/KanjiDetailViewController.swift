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

    @IBOutlet weak var onYomi: UILabel? {
        didSet {
            onYomi?.text = kanji?.onyomi ?? "None"
        }
    }
    @IBOutlet weak var kunYomi: UILabel? {
        didSet {
            kunYomi?.text = kanji?.kunyomi ?? "None"
        }
    }
    @IBOutlet weak var nanori: UILabel? {
        didSet {
            nanori?.text = kanji?.nanori ?? "None"
        }
    }

    @IBOutlet weak var srsBackgroundView: UIView? {
        didSet {
            guard let srsString = kanji?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
            srsBackgroundView?.backgroundColor = srsStatus.color
        }
    }

    @IBOutlet weak var srsIconImageView: UIImageView? {
        didSet {
            guard let srsString = kanji?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
            srsIconImageView?.image = srsStatus.icon
        }
    }

    @IBOutlet weak var nanoriContainer: UIView?

    var kanji: KanjiInfo? {
        didSet {
            guard let kanji = kanji else { return }
            meaningLabel?.text = kanji.meaning
            kanjiStrings = [kanji.character]
        }
    }

    @IBOutlet weak var mainStackView: UIStackView!

    private var kanjiStrings = [String]() {
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

    private func updateStrokeOrderViewController() {
        strokeOrderViewController?.kanjiStrings = self.kanjiStrings
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = addBackground(BackgroundOptions.data.rawValue)
    }

}

// MARK: - PreviewSize
extension KanjiDetailViewController: PreviewSize {
    var previewSize: CGSize {
        return mainStackView.bounds.size
    }
}
