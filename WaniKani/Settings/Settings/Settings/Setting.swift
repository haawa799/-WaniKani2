//
//  Setting.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation

protocol SettingsDelegate: class {
  func settingDidChange(_ setting: Setting)
}

enum SettingSuitKey: String {
  case fastForwardEnabledKey = "fastForwardEnabledKey"
  case ignoreButtonEnabledKey = "ignoreButtonEnabledKey"
  case reorderEnabledKey = "reorderEnabledKey"
  case hideStatusBarKey = "hideStatusBarKey"
  case gameCenterKey = "gameCenterKey"
  case logOutKey = "logOutKey"
  case appleWatchKey = "appleWatchKey"
  case shouldUseGameCenterKey = "shouldUSeGameCenter"
  case ignoreLessonsInIconBadgeKey = "ignoreLessonsInIconBadgeKey"
}

struct Setting: Equatable {
  let key: SettingSuitKey
  let script: UserScript?
  let description: String?

  var delegate: SettingsDelegate?

  var isEnabled: Bool {
    return Defaults.userDefaults.bool(forKey: key.rawValue)
  }

  func setEnabled(_ state: Bool) {
    Defaults.userDefaults.set(state, forKey: key.rawValue)
    Defaults.userDefaults.synchronize()
    delegate?.settingDidChange(self)
  }

  init(key: SettingSuitKey, script: UserScript?, description: String?) {
    self.key = key
    self.description = description
    self.script = script
  }
}

func == (lhs: Setting, rhs: Setting) -> Bool {
  return lhs.key.rawValue == rhs.key.rawValue
}
