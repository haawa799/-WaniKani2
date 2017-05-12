//
//  Kanji.swift
//  StrokeDrawingView
//
//  Created by Andriy K. on 12/4/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import KanjiBezierPaths
import StrokeDrawingView

class KanjiGraphicInfo {

    fileprivate let kanjiProvider = KanjiProvider()

  let color0 = UIColor(red:0.95, green:0, blue:0.63, alpha:1)

  let bezierPathes: [UIBezierPath]
  let kanji: String

  init(kanji: String) {
    self.kanji = kanji
    self.bezierPathes = kanjiProvider.pathesForKanji(kanji) ?? [UIBezierPath]()
  }

  class func kanjiFromString(kanjiChar: String) -> KanjiGraphicInfo? {
    let kanji = KanjiGraphicInfo(kanji: kanjiChar)
    return (kanji.bezierPathes.count > 0) ? kanji : nil
  }

}

extension KanjiGraphicInfo: StrokeDrawingViewDataSource {
    func sizeOfDrawing() -> CGSize {
        return CGSize(width: 109, height: 109)
    }

    func numberOfStrokes() -> Int {
        return bezierPathes.count
    }

    func pathForIndex(index: Int) -> UIBezierPath {
        let path = bezierPathes[index]
        path.lineWidth = 3
        return path
    }

    func animationDurationForStroke(index: Int) -> CFTimeInterval {
        return 0.6
    }

    func colorForStrokeAtIndex(index: Int) -> UIColor {
        return color0
    }

    func colorForUnderlineStrokes() -> UIColor? {
        return UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 0.5)
    }
}

extension UIColor {

  func lighter(amount: CGFloat = 0.25) -> UIColor {
    return hueColorWithBrightnessAmount(amount: 1 + amount)
  }

  func darker(amount: CGFloat = 0.25) -> UIColor {
    return hueColorWithBrightnessAmount(amount: 1 - amount)
  }

  private func hueColorWithBrightnessAmount(amount: CGFloat) -> UIColor {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0

    if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
      return UIColor( hue: hue,
        saturation: saturation,
        brightness: brightness * amount,
        alpha: alpha )
    } else {
      return self
    }

  }

}
