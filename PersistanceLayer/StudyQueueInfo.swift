//
//  StudyQueueInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class StudyQueueInfo: Object {
  var lessonsAvaliable = RealmOptional<Int>()
  var reviewsAvaliable = RealmOptional<Int>()
  dynamic var nextReviewDate: Date?
  var reviewsNextHour = RealmOptional<Int>()
  var reviewsNextDay = RealmOptional<Int>()
  dynamic var userId: String = ""

  convenience init(studyQueue: WaniModel.StudyQueueInfo, userId: String) {
    self.init()
    self.userId = userId
    self.lessonsAvaliable.value = studyQueue.lessonsAvaliable
    self.reviewsAvaliable.value = studyQueue.reviewsAvaliable
    self.nextReviewDate = studyQueue.nextReviewDate
    self.reviewsNextHour.value = studyQueue.reviewsNextHour
    self.reviewsNextDay.value = studyQueue.reviewsNextDay
  }

  var waniModelStruct: WaniModel.StudyQueueInfo {
    return WaniModel.StudyQueueInfo(realmObject: self)
  }

  override static func primaryKey() -> String? {
    return "userId"
  }
}

extension WaniModel.StudyQueueInfo {

  init(realmObject: PersistanceLayer.StudyQueueInfo) {
    self.lessonsAvaliable = realmObject.lessonsAvaliable.value
    self.reviewsAvaliable = realmObject.reviewsAvaliable.value
    self.nextReviewDate = realmObject.nextReviewDate
    self.reviewsNextHour = realmObject.reviewsNextHour.value
    self.reviewsNextDay = realmObject.reviewsNextDay.value
  }

}
