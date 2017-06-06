//
//  ComplicationItem.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/6/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit

public struct ComplicationItem {

  public var text: String
  public var subText: String?
  public var date: Date
  public var color: UIColor
  public var type: Int

  public init(text: String, subText: String?, date: Date, color: UIColor, type: Int) {
    self.text = text
    self.subText = subText
    self.date = date
    self.color = color
    self.type = type
  }

}
