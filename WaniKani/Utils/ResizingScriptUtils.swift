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

fileprivate enum ScreenLayout {
  case iPhone7Plus_Portrait
  case iPhone7Plus_Landscape
  case iPhone7_Portrait
  case iPhone7_Landscape
  case iPhoneSE_Portrait
  case iPhoneSE_Landscape
  case iPhone4s_Portrait
  case iPhone4s_Landscape
  case iPad_Portrait
  case iPad_Landscape
  case iPadSlideOverSmall_Portrait
  case iPadSlideOverSmall_Landscape
  case iPadSlideOverMedium_Portrait
  case iPadSlideOverMedium_Landscape
  case iPadSlideOverLarge_Landscape
}

struct ScreenLayoutConfiguration {

  fileprivate let size: CGSize
  fileprivate let layout: ScreenLayout

  init?(size: CGSize) {
    self.size = size
    switch (size.width, size.height) {
      // 7+
      case (414.0, 736.0): layout = .iPhone7Plus_Portrait
      case (736.0, 414.0): layout = .iPhone7Plus_Landscape
      // 7
      case (375.0, 667.0): layout = .iPhone7_Portrait
      case (667.0, 375.0): layout = .iPhone7_Landscape
      // SE
      case (320.0, 568.0): layout = .iPhoneSE_Portrait
      case (568.0, 320.0): layout = .iPhoneSE_Landscape
      // 4s
      case (320.0, 480.0): layout = .iPhone4s_Portrait
      case (480.0, 320.0): layout = .iPhone4s_Portrait
      // iPad
      case (768.0, 1024.0): layout = .iPad_Portrait
      case (1024.0, 768.0): layout = .iPad_Landscape
      // side-by-side
      case (320.0, 768.0): layout = .iPadSlideOverSmall_Landscape
      case (507.0, 768.0): layout = .iPadSlideOverMedium_Landscape
      case (694.0, 768.0): layout = .iPadSlideOverLarge_Landscape
      case (438.0, 1024.0): layout = .iPadSlideOverMedium_Portrait
      case (320.0, 1024.0): layout = .iPadSlideOverSmall_Portrait
      default: return nil
    }
  }

  var width: Int {
    return Int(size.width)
  }

  var height: Int {
    var height: Int
    switch layout {
      case .iPhone7Plus_Portrait: height = 100
      case .iPhone7Plus_Landscape: height = 100
      case .iPhone7_Portrait: height = 100
      case .iPhone7_Landscape: height = 100
      case .iPhoneSE_Portrait: height = 100
      case .iPhoneSE_Landscape: height = 100
      case .iPhone4s_Portrait: height = 100
      case .iPhone4s_Landscape: height = 100
      case .iPad_Portrait: height = 460
      case .iPad_Landscape: height = 130
      case .iPadSlideOverSmall_Portrait: height = 460
      case .iPadSlideOverSmall_Landscape: height = 240
      case .iPadSlideOverMedium_Portrait: height = 560
      case .iPadSlideOverMedium_Landscape: height = 240
      case .iPadSlideOverLarge_Landscape: height = 240
    }
    return height
  }

  var font: Int {
    switch layout {
      case .iPhone7Plus_Portrait: return 100
      case .iPhone7Plus_Landscape: return 100
      case .iPhone7_Portrait: return 100
      case .iPhone7_Landscape: return 100
      case .iPhoneSE_Portrait: return 100
      case .iPhoneSE_Landscape: return 100
      case .iPhone4s_Portrait: return 100
      case .iPhone4s_Landscape: return 100
      case .iPad_Portrait: return 100
      case .iPad_Landscape: return 60
      case .iPadSlideOverSmall_Portrait: return 500
      case .iPadSlideOverSmall_Landscape: return 150 //
      case .iPadSlideOverMedium_Portrait: return 200
      case .iPadSlideOverMedium_Landscape: return 190 //
      case .iPadSlideOverLarge_Landscape: return 250 //
    }
  }
}
