//
//  Setting.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation

protocol SettingsDelegate {
  func settingDidChange(_ setting: Setting)
}

enum SettingSuitKey: String {
  case fastForwardEnabledKey = "fastForwardEnabledKey"
  case ignoreButtonEnabledKey = "ignoreButtonEnabledKey"
  case smartResizingEnabledKey = "smartResizingEnabledKey"
  case reorderEnabledKey = "reorderEnabledKey"
  case hideStatusBarKey = "hideStatusBarKey"
  case gameCenterKey = "gameCenterKey"
  case shouldUseGameCenterKey = "shouldUSeGameCenter"
  case ignoreLessonsInIconBadgeKey = "ignoreLessonsInIconBadgeKey"
}

struct Setting: Equatable {
  let key: SettingSuitKey
  let script: UserScript?
  let description: String?

  var delegate: SettingsDelegate?

  var isEnabled: Bool {
    return UserDefaults.standard.bool(forKey: key.rawValue)
  }

  func setEnabled(_ state: Bool) {
    UserDefaults.standard.set(state, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
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
