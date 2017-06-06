//
//  InterfaceController.swift
//  WaniTokei WatchKit Extension
//
//  Created by Andriy K. on 8/29/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import WatchKit
import Foundation
import TokeiModel

class CriticalItemsInterfaceController: WKInterfaceController {
  
  @IBOutlet var tableView: WKInterfaceTable!
  let persistenceManager = PersistanceManager.sharedInstance
  let networkManager = NetworkingManager()
  
  var items: [Item]? {
    didSet {
      guard let items = items else { return }
      tableView.setNumberOfRows(items.count, withRowType: "itemCell")
      for (index, item) in items.enumerated() {
        guard let controller = tableView.rowController(at: index) as? ItemRowController else { return }
        controller.mainLabel.setText(item.mainTitle)
        guard var percentageString = item.percentage else { break }
        percentageString += "%"
        controller.leftLabel.setText(percentageString)
        controller.backgroundGroup.setBackgroundColor(item.backgroundColor)
      }
      tableView.scrollToRow(at: 0)
    }
  }
  
  func loadItemsFromPersistence() {
    persistenceManager.loadItemsFromPersistence { (items) in
      self.items = items
    }
  }
  
  func fetchCriticalList() {
    let success = networkManager.sendRequest { (items) in
      guard let items = items else { return }
      self.persistenceManager.saveItemsToPersistence(items: items, completion: {
        self.loadItemsFromPersistence()
      })
    }
    if success == false {
      showError(message: "You need to log in on the iPhone first.")
    }
  }
  
  private func showError(message: String) {
    presentController(withName: "ErrorInterfaceController", context: ["message": message])
  }
  
  override func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
    super.handleUserActivity(userInfo)
    guard userInfo != nil else { return }
    persistenceManager.currentComplicationItem { (item) in
      guard let item = item else { return }
      self.persistenceManager.fetchItemForComplication(complication: item, handler: { (item) in
        self.pushController(withName: "Details", context: item)
      })
    }
  }
  
}

// MARK: - WKInterfaceController
extension CriticalItemsInterfaceController {
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    loadItemsFromPersistence()
  }
  
  override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
    return items?[rowIndex]
  }
  
}

// MARK: - Actions
extension CriticalItemsInterfaceController {
  
  @IBAction func refreshAction() {
    fetchCriticalList()
  }
  
}
