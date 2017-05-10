//
//  DateExtensions.swift
//  WaniKani
//
//  Created by Andriy K. on 9/22/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

extension Date {

  func waitingTime() -> (string: String, hours: Int)? {
    let calendar = Calendar.current
    let flags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute])

    let components = calendar.dateComponents(flags, from: Date(), to: self)

    var nextReviewString = "今"

    guard let years = components.year,
    let months = components.month,
    let days = components.day,
    let hours = components.hour,
      let minutes = components.minute else { return nil }

    if years <= 0 {
      if months <= 0 {
        if days <= 0 {
          if hours <= 0 {
            if minutes > 0 {
              nextReviewString = "\(minutes)min"
            }
          } else {
            nextReviewString = "\(hours)h"
          }
        } else {
          var s = "s"
          if days == 1 {
            s = ""
          }
          nextReviewString = "\(days) day\(s)"
        }
      } else {
        var s = "s"
        if months == 1 {
          s = ""
        }
        nextReviewString = "\(months) month\(s)"
      }
    } else {
      var s = "s"
      if years == 1 {
        s = ""
      }
      nextReviewString = "\(years) year\(s)"
    }
    return (nextReviewString, hours)
  }

}
