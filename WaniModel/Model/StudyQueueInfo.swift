//
//  StudyQueueInfo.swift
//  Pods
//
//  Created by Andriy K. on 12/10/15.
//
//

import Foundation

public struct StudyQueueInfo: WaniKaniDataStructure {

  struct DictionaryKey {
    static let avaliableLessons = "lessons_available"
    static let avaliableReviews = "reviews_available"
    static let nextReviewDate = "next_review_date"
    static let reviewsNextHour = "reviews_available_next_hour"
    static let reviewsNextDay = "reviews_available_next_day"
  }

  public var lessonsAvaliable: Int?
  public var reviewsAvaliable: Int?
  public var nextReviewDate: Date?
  public var reviewsNextHour: Int?
  public var reviewsNextDay: Int?

}

extension StudyQueueInfo {

  public init(dict: [String : Any]) {
    lessonsAvaliable = (dict[DictionaryKey.avaliableLessons] as? Int)
    reviewsAvaliable = (dict[DictionaryKey.avaliableReviews] as? Int)
    if let reviewDate = dict[DictionaryKey.nextReviewDate] as? Int {
      nextReviewDate = Date(timeIntervalSince1970: TimeInterval(reviewDate))
    }
    reviewsNextHour = (dict[DictionaryKey.reviewsNextHour] as? Int)
    reviewsNextDay = (dict[DictionaryKey.reviewsNextDay] as? Int)
  }
}
