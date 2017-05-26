//
//  NotificationManager.swift
//
//
//  Created by Andriy K. on 8/12/15.
//
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {

  static let sharedInstance = NotificationManager()

  private var lastAttemptDate: Date?

  func scheduleNextReviewNotification(date: Date) {

    // Make sure notification is in future
    let timeTillDate = date.timeIntervalSinceNow
//    guard timeTillDate > 0 else { return }

    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    //Set the content of the notification
    let cancel = UNNotificationAction(identifier: "CancelIdentifier",
                                      title: "Proceed to reviews",
                                      options: [.foreground])

    let category = UNNotificationCategory(identifier: "actions", actions: [cancel], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])

    let content = UNMutableNotificationContent()
    content.body = "New reviews available"
    content.sound = UNNotificationSound(named: "notification.m4a")
    content.categoryIdentifier = "actions"

    //Set the trigger of the notification -- here a timer.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)

    //Set the request for the notification from the above
    let request = UNNotificationRequest(
        identifier: "New review message",
        content: content,
        trigger: trigger
    )

    //Add the notification to the currnet notification center
    UNUserNotificationCenter.current().add(
        request, withCompletionHandler: nil)
  }

    func updateIconCounter(number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }

  func unscheduleNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  }

}
