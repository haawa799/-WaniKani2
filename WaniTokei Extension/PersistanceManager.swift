//
//  PersistanceManager.swift
//  WaniTokei
//
//  Created by Andriy K. on 9/6/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift
import WaniModel
import ClockKit

class PersistanceManager {

  static let sharedInstance: PersistanceManager = {
    let instance = PersistanceManager()
    return instance
  }()

  private let realmHelper = RealmHelper()

  /// Returns [Item] array to main thread from persistant storage
  func loadItemsFromPersistence(handler: @escaping ([Item]) -> Void) {
    realmHelper.fetchRealmCriticalItems { (list) in
      let convertedItems = list.convertedItems()
      DispatchQueue.main.async {
        handler(convertedItems)
      }
    }
  }

  /// Returns complication items array to main thread from persistant storage
  func loadComplicationItemsFromPersistence(handler: @escaping ([ComplicationItem]) -> Void) {
    realmHelper.fetchComplicationItems { (list) in
      DispatchQueue.main.async {
        handler(list)
      }
    }
  }

  func saveItemsToPersistence(items: [Item], completion: @escaping () -> Void) {
    realmHelper.saveCriticalItemsToRealm(list: items, completion: completion)
    saveItemsForComplications(items: items, completion: {
      guard let complications = CLKComplicationServer.sharedInstance().activeComplications else { return }
      for complication in complications {
        CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
      }
    })
  }

  private func saveItemsForComplications(items: [Item], completion: @escaping () -> Void) {

    guard items.count > 0 else { return }
    // All logic here. Plans for future: allow user to customize following numbers
    let topTen = items.prefix(20)

    let numberOfDays = 20  // For how many days in the future you want to create events for
    let start = 8 // We assume user wakes up at this hour
    let end = 23 // We assume user falls asleep at this hour ( items will not change during his sleep time)
    let step = 0.5 // Step, for how often to change items (in hours)

    var baginning = Date()
    baginning = baginning.setTimeOfDate(start, minute: 0, second: 0)

    let itemsPerDay = Int( Float(end - start) / Float(step) )

    var todayDatesArray = [Date]()

    var current = baginning
    let minuteStep = Int(step * 60)
    for _ in 0...itemsPerDay {
      todayDatesArray.append(current)
      current = current.dateByAddingMinutes(minuteStep)
    }

    var allDates = [Date]()
    for day in 0...numberOfDays {
      let items = todayDatesArray.map({ $0.dateByAddingDays(day) })
      allDates.append(contentsOf: items)
    }

    let allItems = allDates.enumerated().map { (__val: (Int, Date)) -> RealmComplicationItem in let (index, date) = __val
      let count = topTen.count
      let realIndex = index % count
      let itemInfo = topTen[realIndex]
      return RealmComplicationItem.newItem(itemInfo: itemInfo, date: date)
    }

    realmHelper.saveComplicationItems(list: allItems, completion: completion)

  }

  public func currentComplicationItem(handler: @escaping (ComplicationItem?) -> Void) {
    realmHelper.currentComplicationItem { (item) in
      DispatchQueue.main.async {
        handler(item)
      }
    }
  }

  public func pastItems(countDate: NSDate, handler: @escaping ([ComplicationItem]) -> Void) {
    realmHelper.pastItems(date: countDate) { (items) in
      DispatchQueue.main.async {
        handler(items)
      }
    }
  }

  public func futureItems(date: NSDate, limit: Int, handler: @escaping ([ComplicationItem]) -> Void) {
    realmHelper.futureItems(date: date, limit: limit) { (items) in
      DispatchQueue.main.async {
        handler(items)
      }
    }
  }

  public func fetchItemForComplication(complication: ComplicationItem, handler: @escaping (Item?) -> Void) {
    realmHelper.fetchItemForComplication(complication: complication) { (item) in
      DispatchQueue.main.async {
        handler(item)
      }
    }
  }

}
