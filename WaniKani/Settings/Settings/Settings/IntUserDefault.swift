//
//  IntUserDefault.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation

struct IntUserDefault {
  let key: String

  var delegate: SettingsDelegate?
  private var internalValue: AnyObject!

  var value: Int {
    didSet {
      if value != oldValue {
        Defaults.userDefaults.set(value, forKey: key)
        Defaults.userDefaults.synchronize()
      }
    }
  }

  init(key: String) {
    self.key = key
    self.value = Defaults.userDefaults.integer(forKey: key)
  }
}
