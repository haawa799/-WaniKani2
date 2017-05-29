//
//  UserActivityManager.swift
//  WaniKani
//
//  Created by Andriy K. on 5/28/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

enum ShortcutIdentifier {
    case lessons
    case reviews

    init?(string: String) {
        switch string {
        case "Lessons": self = .lessons
        case "Review": self = .reviews
        default: return nil
        }
    }
}

class UserActivityManager {

  func newStudyQueueData(studyQueue: StudyQueueInfo) {

    var updatedShortcutItems = [UIMutableApplicationShortcutItem]()

    if (studyQueue.reviewsAvaliable ?? 0) > 0 {
      let reviewItem = UIMutableApplicationShortcutItem(type: "Review", localizedTitle: "Review")
      reviewItem.icon = UIApplicationShortcutIcon(templateImageName: "reviews_quick")
      updatedShortcutItems.append(reviewItem)
    }

    if (studyQueue.lessonsAvaliable ?? 0) > 0 {
      let lessonsItem = UIMutableApplicationShortcutItem(type: "Lessons", localizedTitle: "Lessons")
      lessonsItem.icon = UIApplicationShortcutIcon(templateImageName: "lessons_quick")
      updatedShortcutItems.append(lessonsItem)
    }

    UIApplication.shared.shortcutItems = updatedShortcutItems
  }
}
