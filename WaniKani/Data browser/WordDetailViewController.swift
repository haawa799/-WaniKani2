//
//  KanjiDetailViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/25/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

class WordDetailViewController: UIViewController, BluredBackground, StoryboardInstantiable {
  @IBOutlet weak var levelKanji: UILabel? {
    didSet {
      guard let level = word?.level else { return }
      levelKanji?.text = "\(level)"
    }
  }

  @IBOutlet weak var meaningLabel: UILabel? {
    didSet {
      meaningLabel?.text = word?.meaning
    }
  }

  @IBOutlet weak var srsLabel: UILabel? {
    didSet {
      srsLabel?.text = word?.userSpecific?.srs
    }
  }

  @IBOutlet weak var wordLabel: UILabel? {
    didSet {
      wordLabel?.text = word?.character
    }
  }

  @IBOutlet weak var readingLabel: UILabel? {
    didSet {
      readingLabel?.text = word?.kana
    }
  }

  @IBOutlet weak var srsBackgroundView: UIView? {
    didSet {
      guard let srsString = word?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
      srsBackgroundView?.backgroundColor = srsStatus.color
    }
  }

  @IBOutlet weak var srsIconImageView: UIImageView? {
    didSet {
      guard let srsString = word?.userSpecific?.srs?.lowercased(), let srsStatus = SRSStatus(rawValue: srsString) else { return }
      srsIconImageView?.image = srsStatus.icon
    }
  }

  @IBOutlet weak var nanoriContainer: UIView?

  var word: WordInfo?

  override func viewDidLoad() {
    super.viewDidLoad()
    _ = addBackground(BackgroundOptions.data.rawValue)
  }

}
