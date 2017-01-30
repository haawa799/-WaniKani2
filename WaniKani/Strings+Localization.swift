//
//  Strings+Localization.swift
//  WaniKani
//
//  Created by Andriy K. on 1/30/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
