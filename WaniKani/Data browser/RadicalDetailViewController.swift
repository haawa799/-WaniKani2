//
//  KanjiDetailViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/25/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

class RadicalDetailViewController: UIViewController, BluredBackground, StoryboardInstantiable {
    @IBOutlet weak var levelKanji: UILabel? {
        didSet {
            guard let level = radical?.level else { return }
            levelKanji?.text = "\(level)"
        }
    }
    @IBOutlet weak var radicalLabel: UILabel? {
        didSet {
            guard let radicalCharacter = radical?.character else {
                radicalLabel?.isHidden = true
                radicalImageView?.isHidden = false
                return
            }
            radicalLabel?.text = radicalCharacter
            radicalLabel?.isHidden = false
            radicalImageView?.isHidden = true
        }
    }

    @IBOutlet weak var meaningLabel: UILabel? {
        didSet {
            meaningLabel?.text = radical?.meaning
            radicalImageView?.isHidden = true
        }
    }
    @IBOutlet weak var radicalImageView: UIImageView? {
        didSet {
            guard let radicalImageURLString = radical?.image, let url = URL(string: radicalImageURLString) else {
                radicalImageView?.isHidden = true
                radicalLabel?.isHidden = false
                return
            }
            radicalImageView?.isHidden = false
            radicalLabel?.isHidden = true
            radicalImageView?.kf.setImage(with: url)
        }
    }

    @IBOutlet weak var srsLabel: UILabel? {
        didSet {
            srsLabel?.text = radical?.userSpecific?.srs
        }
    }

    @IBOutlet weak var srsBackgroundView: UIView? {
        didSet {
            guard let srsString = radical?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
            srsBackgroundView?.backgroundColor = srsStatus.color
        }
    }

    @IBOutlet weak var srsIconImageView: UIImageView? {
        didSet {
            guard let srsString = radical?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
            srsIconImageView?.image = srsStatus.icon
        }
    }

    var radical: RadicalInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = addBackground(BackgroundOptions.data.rawValue)
    }

}
