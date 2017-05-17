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

  fileprivate static let kanjiProvider: KanjiProvider! = {
      guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
          return nil
      }
      let url = URL(fileURLWithPath: path)
      return KanjiProvider(appDocumentsURL: url, fileManager: FileManager.default)
  }()

  let color0 = UIColor(red:0.95, green:0, blue:0.63, alpha:1)

  let bezierPathes: [UIBezierPath]
  let kanji: String

  init?(kanji: String) {
    guard let bezierPaths = KanjiGraphicInfo.kanjiProvider.pathesForKanji(kanji) else { return nil }
    self.kanji = kanji
    self.bezierPathes = bezierPaths
  }

  class func kanjiFromString(kanjiChar: String) -> KanjiGraphicInfo? {
    return KanjiGraphicInfo(kanji: kanjiChar)
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
