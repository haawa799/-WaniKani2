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

public class StudyQueueInfo: Object {
  public var lessonsAvaliable = RealmOptional<Int>()
  public var reviewsAvaliable = RealmOptional<Int>()
  public dynamic var nextReviewDate: Date?
  public var reviewsNextHour = RealmOptional<Int>()
  public var reviewsNextDay = RealmOptional<Int>()

  public convenience init(userInfo: WaniModel.StudyQueueInfo) {
    self.init()
    self.lessonsAvaliable.value = userInfo.lessonsAvaliable
    self.reviewsAvaliable.value = userInfo.reviewsAvaliable
    self.nextReviewDate = userInfo.nextReviewDate
    self.reviewsNextHour.value = userInfo.reviewsNextHour
    self.reviewsNextDay.value = userInfo.reviewsNextDay
  }

  public var waniModelStruct: WaniModel.StudyQueueInfo {
    return WaniModel.StudyQueueInfo(realmObject: self)
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
