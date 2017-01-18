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
  fileprivate let id: String
  
  init(setting: Setting) {
    id = setting.key.rawValue
    titleString = setting.description ?? ""
    state = setting.isEnabled
  }
  
}

extension SettingsScriptCellViewModel {
  
  var scriptID: String {
    return id
  }
  
  var switchState: Bool {
    return state
  }
  
  var title: String {
    return titleString
  }
  
}
