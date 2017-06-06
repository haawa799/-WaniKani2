//
//  ItemDetailsInterfaceController.swift
//  WaniTokei
//
//  Created by Andriy K. on 8/31/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import WatchKit
import Foundation
import TokeiModel

class ItemDetailsInterfaceController: WKInterfaceController {
  
  var item: Item? {
    didSet {
      guard let item = item else { return }
      mainLabel.setText(item.mainTitle)
      mainLabel.setTextColor(item.backgroundColor)
      percentageLabel.setText(item.meaning)
      guard let percentage = item.percentage else { return }
      self.setTitle("\(percentage)%")
      readingLabel.setText(item.reading)
    }
  }
  @IBOutlet var mainLabel: WKInterfaceLabel!
  @IBOutlet var percentageLabel: WKInterfaceLabel!
  @IBOutlet var readingLabel: WKInterfaceLabel!
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    item = context as? Item
  }
  
}
