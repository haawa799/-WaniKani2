//
//  SettingsScriptCellViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import Foundation

struct SettingsScriptCellViewModel: SettingsScriptCellDataSource {

  fileprivate let titleString: String
  fileprivate let state: Bool
  fileprivate let identifier: String

  init(setting: Setting) {
    identifier = setting.key.rawValue
    titleString = setting.description ?? ""
    state = setting.isEnabled
  }

}

extension SettingsScriptCellViewModel {

  var scriptID: String {
    return identifier
  }

  var switchState: Bool {
    return state
  }

  var title: String {
    return titleString
  }

}
