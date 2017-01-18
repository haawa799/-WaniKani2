//
//  Array.swift
//  WaniKani
//
//  Created by Andriy K. on 4/4/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
  
  // Remove first collection element that is equal to the given `object`:
  mutating func removeObject(_ object : Iterator.Element) {
    if let index = self.index(of: object) {
      self.remove(at: index)
    }
  }
  
}
