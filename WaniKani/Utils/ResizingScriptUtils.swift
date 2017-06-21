//
//  ResizingScriptUtils.swift
//  WaniKani
//
//  Created by Andriy K. on 2/20/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

// All names relates to screen size only
// swiftlint:disable cyclomatic_complexity
private enum ScreenLayout {
  case iPhone7PlusPortrait
  case iPhone7PlusLandscape
  case iPhone7Portrait
  case iPhone7Landscape
  case iPhoneSEPortrait
  case iPhoneSELandscape
  case iPhone4sPortrait
  case iPhone4sLandscape
  case iPadPortrait
  case iPadLandscape
  case iPadSlideOverSmallPortrait
  case iPadSlideOverSmallLandscape
  case iPadSlideOverMediumPortrait
  case iPadSlideOverMediumLandscape
  case iPadSlideOverLargeLandscape
}

struct ScreenLayoutConfiguration {

  private let size: CGSize
  private let layout: ScreenLayout

  init?(size: CGSize) {
    self.size = size
    switch (size.width, size.height) {
      // 7+
      case (414.0, 736.0): layout = .iPhone7PlusPortrait
      case (736.0, 414.0): layout = .iPhone7PlusLandscape
      // 7
      case (375.0, 667.0): layout = .iPhone7Portrait
      case (667.0, 375.0): layout = .iPhone7Landscape
      // SE
      case (320.0, 568.0): layout = .iPhoneSEPortrait
      case (568.0, 320.0): layout = .iPhoneSELandscape
      // 4s
      case (320.0, 480.0): layout = .iPhone4sPortrait
      case (480.0, 320.0): layout = .iPhone4sPortrait
      // iPad
      case (768.0, 1024.0): layout = .iPadPortrait
      case (1024.0, 768.0): layout = .iPadLandscape
      // side-by-side
      case (320.0, 768.0): layout = .iPadSlideOverSmallLandscape
      case (507.0, 768.0): layout = .iPadSlideOverMediumLandscape
      case (694.0, 768.0): layout = .iPadSlideOverLargeLandscape
      case (438.0, 1024.0): layout = .iPadSlideOverMediumPortrait
      case (320.0, 1024.0): layout = .iPadSlideOverSmallPortrait
      default: return nil
    }
  }

  var width: Int {
    return Int(size.width)
  }

  var height: Int {
    var height: Int
    switch layout {
      case .iPhone7PlusPortrait: height = 300
      case .iPhone7PlusLandscape: height = 75
      case .iPhone7Portrait: height = 250
      case .iPhone7Landscape: height = 40
      case .iPhoneSEPortrait: height = 180
      case .iPhoneSELandscape: height = 40
      case .iPhone4sPortrait: height = 90
      case .iPhone4sLandscape: height = 90
      case .iPadPortrait: height = 460
      case .iPadLandscape: height = 130
      case .iPadSlideOverSmallPortrait: height = 460
      case .iPadSlideOverSmallLandscape: height = 240
      case .iPadSlideOverMediumPortrait: height = 560
      case .iPadSlideOverMediumLandscape: height = 240
      case .iPadSlideOverLargeLandscape: height = 240
    }
    return height
  }

  var font: Int {
    switch layout {
      case .iPhone7PlusPortrait: return 250
      case .iPhone7PlusLandscape: return 110
      case .iPhone7Portrait: return 230
      case .iPhone7Landscape: return 60
      case .iPhoneSEPortrait: return 100
      case .iPhoneSELandscape: return 50
      case .iPhone4sPortrait: return 60
      case .iPhone4sLandscape: return 60
      case .iPadPortrait: return 100
      case .iPadLandscape: return 30
      case .iPadSlideOverSmallPortrait: return 500
      case .iPadSlideOverSmallLandscape: return 150
      case .iPadSlideOverMediumPortrait: return 200
      case .iPadSlideOverMediumLandscape: return 190
      case .iPadSlideOverLargeLandscape: return 250
    }
  }
}
