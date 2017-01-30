//
//  WebSessionType.swift
//  WaniKani
//
//  Created by Andriy K. on 1/30/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

enum BarAction {
  case finish
  case submitToGameCenter
  case strokes
}

enum WebSessionType: BottomBarContainerDataSource {

  fileprivate struct Constants {
    static let defaultReviewItems = [
      BarItemData.item(title: "review.bottombar.button.title.submit.to.gamcenter".localized),
      BarItemData.spacing,
      BarItemData.item(title: "review.bottombar.button.title.strokes".localized)
    ]
    static let defaultLessonsItems = [
      BarItemData.item(title: "review.bottombar.button.title.finish".localized)
    ]
  }

  case lesson
  case review

  var url: String {
    switch self {
    case .lesson: return "https://www.wanikani.com/lesson/session"
    case .review: return "https://www.wanikani.com/review/session"
    }
  }
}

// MARK: - BottomBarContainerDataSource
extension WebSessionType {

  func itemForIndex(index: Int) -> BarItemData {
    switch self {
    case .lesson: return Constants.defaultLessonsItems[index]
    case .review: return Constants.defaultReviewItems[index]
    }
  }

  func numberOfItems() -> Int {
    switch self {
    case .lesson: return Constants.defaultLessonsItems.count
    case .review: return Constants.defaultReviewItems.count
    }
  }

  func barActionForIndex(index: Int) -> BarAction {
    switch (index, self) {
    case (0, .lesson): return .finish
    case (0, .review): return .submitToGameCenter
    case (2, .review): return .strokes
    default: break
    }
    return .finish
  }
}
