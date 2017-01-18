//
//  LabelWithAdaptiveTextHeight.swift
//  WaniKani
//
//  Created by Andriy K. on 3/18/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation
import UIKit

class LabelWithAdaptiveTextHeight: UILabel {
  
  var heightKoefitient: CGFloat = 1.0
  
  override func layoutSubviews() {
    super.layoutSubviews()
    font = fontToFitHeight()
  }
  
  // Returns an UIFont that fits the new label's height.
  fileprivate func fontToFitHeight() -> UIFont {
    
    var minFontSize: CGFloat = 4
    var maxFontSize: CGFloat = 67
    var fontSizeAverage: CGFloat = 0
    var textAndLabelHeightDiff: CGFloat = 0
    
    while (minFontSize <= maxFontSize) {
      fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
      
      if let labelText: NSString = text as NSString? {
        let labelHeight = frame.size.height * heightKoefitient
        
        let testStringHeight = labelText.size(
          attributes: [NSFontAttributeName: font.withSize(fontSizeAverage)]
          ).height
        
        textAndLabelHeightDiff = labelHeight - testStringHeight
        
        if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
          if (textAndLabelHeightDiff < 0) {
            return font.withSize(fontSizeAverage - 1)
          }
          return font.withSize(fontSizeAverage)
        }
        
        if (textAndLabelHeightDiff < 0) {
          maxFontSize = fontSizeAverage - 1
          
        } else if (textAndLabelHeightDiff > 0) {
          minFontSize = fontSizeAverage + 1
          
        } else {
          return font.withSize(fontSizeAverage)
        }
      } else {
        break
      }
    }
    return font.withSize(fontSizeAverage)
  }
  
}
