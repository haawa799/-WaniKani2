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
  fileprivate var internalValue: AnyObject!
  
  var value: Int {
    didSet {
      if value != oldValue {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
      }
    }
  }
  
  init(key: String) {
    self.key = key
    self.value = UserDefaults.standard.integer(forKey: key)
  }
}
