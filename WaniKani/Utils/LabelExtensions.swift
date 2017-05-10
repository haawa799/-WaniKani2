//
//  LabelExtensions.swift
//  WaniKani
//
//  Created by Andriy K. on 3/16/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

extension CGRect {
  func centerAndAdjustPercentage(percentage: CGFloat) -> CGRect {
    let w = self.width
    let h = self.height

    let newW = w * percentage
    let newH = h * percentage
    let newX = (w - newW) / 2
    let newY = (h - newH) / 2

    return CGRect(x: newX, y: newY, width: newW, height: newH)
  }
}
