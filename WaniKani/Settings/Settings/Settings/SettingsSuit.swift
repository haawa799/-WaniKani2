//
//  SettingsSuit.swift
//  WaniKani
//
//  Created by Andriy K. on 10/7/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit

private struct ScriptSetting {
  static let fastForwardScript = UserScript(filename: "fast_forward", scriptName: "Fast forward")
  static let ignoreButtonScript = UserScript(filename: "ignore", scriptName: "Ignore button")
  static let smartResizingScript = UserScript(filename: "resize", scriptName: "Smart resize")
  static let reorderScript = UserScript(filename: "reorder", scriptName: "Reorder script")
  static let scoreScript = UserScript(filename: "score", scriptName: "Score script")
  
  static func resizingScriptForCurrentMetrics(_ statusBarHidden: Bool) -> UserScript {
    var resizingScriptCopy = ScriptSetting.smartResizingScript
    resizingScriptCopy.modifyScript({ (script) -> (String) in
      let s = script
      return s
    })
    return resizingScriptCopy
  }
}

private struct SettingsSuitSettings {
  
  static let fastForwardSetting: Setting = Setting(key: SettingSuitKey.fastForwardEnabledKey, script: ScriptSetting.fastForwardScript, description: ScriptSetting.fastForwardScript.name)
  static let ignoreButtonSetting: Setting = Setting(key: SettingSuitKey.ignoreButtonEnabledKey, script: ScriptSetting.ignoreButtonScript, description: ScriptSetting.ignoreButtonScript.name)
  static let reorderSetting: Setting = Setting(key: SettingSuitKey.reorderEnabledKey, script: ScriptSetting.reorderScript, description: ScriptSetting.reorderScript.name)
  static let smartResizingSetting: Setting = Setting(key: SettingSuitKey.smartResizingEnabledKey, script: ScriptSetting.smartResizingScript, description: ScriptSetting.smartResizingScript.name)
  // === Second section ===================
  static let hideStatusBarSetting: Setting = Setting(key: SettingSuitKey.hideStatusBarKey, script: nil, description: "Status bar hidden on Reviews")
  static let shouldUseGCSetting: Setting = Setting(key: SettingSuitKey.shouldUseGameCenterKey, script: nil, description: "Use GameCenter")
  static let gameCenterDummySetting: Setting = Setting(key: SettingSuitKey.gameCenterKey, script: nil, description: "Game center")
  static let ignoreLessonsInIconCounter: Setting = Setting(key: SettingSuitKey.ignoreLessonsInIconBadgeKey, script: nil, description: "Ignore lessons in icon badge")
  
  static var userScriptsForReview: [UserScript] {
    var scripts = [UserScript]()
    if fastForwardSetting.isEnabled == true { scripts.append(ScriptSetting.fastForwardScript) }
    if ignoreButtonSetting.isEnabled == true { scripts.append(ScriptSetting.ignoreButtonScript) }
    if reorderSetting.isEnabled == true { scripts.append(ScriptSetting.reorderScript) }
    scripts.append(ScriptSetting.scoreScript)
    if smartResizingSetting.isEnabled == true { _ = ScriptSetting.resizingScriptForCurrentMetrics(hideStatusBarSetting.isEnabled) }
    return scripts
  }
  
  static var allSettings: [Setting] {
    return [
      SettingsSuitSettings.fastForwardSetting,
      SettingsSuitSettings.ignoreButtonSetting,
      SettingsSuitSettings.reorderSetting,
      SettingsSuitSettings.smartResizingSetting,
      SettingsSuitSettings.hideStatusBarSetting,
      SettingsSuitSettings.shouldUseGCSetting,
      SettingsSuitSettings.ignoreLessonsInIconCounter
    ]
  }
}

public struct SettingsSuit {
  
  public let userDefaults: UserDefaults
//  fileprivate let keychainManager: KeychainManager
//  
//  init(userDefaults: UserDefaults, keychainManager: KeychainManager) {
//    self.userDefaults = userDefaults
//    self.keychainManager = keychainManager
//  }
  
  
  fileprivate func settingWithID(_ id: String) -> Setting? {
    let setting = SettingsSuitSettings.allSettings.filter ({ $0.key.rawValue == id }).first
    return setting
  }
}

// Public API
extension SettingsSuit {
  
  var collectionViewViewModel: ListViewModel {
    let headerColor = ColorConstants.settingsTintColor
    let sections = [
      // Section 0
      ListSection(header: nil, items: []),
      // Section 1
      ListSection(header: ListCellDataItem(viewModel: (DashboardHeaderViewModel(title: "Scripts for Reviews", color: headerColor) as ViewModel), reuseIdentifier: DashboardHeader.identifier), items: [
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.fastForwardSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier),
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.ignoreButtonSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier),
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.reorderSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier),
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.smartResizingSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier)
        ]),
      // Section 2
      ListSection(header: ListCellDataItem(viewModel: (DashboardHeaderViewModel(title: "Other options", color: headerColor) as ViewModel), reuseIdentifier: DashboardHeader.identifier), items: [
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.hideStatusBarSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier),
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.shouldUseGCSetting) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier),
        ListCellDataItem(viewModel: (GameCenterCellViewModel(setting: SettingsSuitSettings.gameCenterDummySetting) as ViewModel), reuseIdentifier: GameCenterCollectionViewCell.identifier)
        ]),
      // Section 3
      ListSection(header: ListCellDataItem(viewModel: (DashboardHeaderViewModel(title: "Notifications options", color: headerColor) as ViewModel), reuseIdentifier: DashboardHeader.identifier), items: [
        ListCellDataItem(viewModel: (SettingsScriptCellViewModel(setting: SettingsSuitSettings.ignoreLessonsInIconCounter) as ViewModel), reuseIdentifier: SettingsScriptCell.identifier)
        ])
    ]
    return ListViewModel(sections: sections)
  }
  
  var hideStatusBarEnabled: Bool {
    return SettingsSuitSettings.hideStatusBarSetting.isEnabled
  }
  
  var shouldUseGameCenter: Bool {
    return SettingsSuitSettings.shouldUseGCSetting.isEnabled
  }
  
  func changeSetting(_ id: String, state: Bool) {
    guard let setting = settingWithID(id) else { return }
    setting.setEnabled(state)
  }
  
  func applyResizingScriptsToWebView(_ webView: UIWebView, type: WebSessionType) {
    guard type == .review else { return }
    let script = ScriptSetting.resizingScriptForCurrentMetrics(SettingsSuitSettings.hideStatusBarSetting.isEnabled)
    webView.stringByEvaluatingJavaScript(from: script.script)
  }
  
  static func applyUserScriptsToWebView(_ webView: UIWebView, type: WebSessionType) {
    
    var scripts = [UserScript]()
    switch type {
    case .review: scripts = SettingsSuitSettings.userScriptsForReview
    case .lesson: break
    }
    
    for script in scripts {
      webView.stringByEvaluatingJavaScript(from: script.script)
    }
    
//    if let user = self.keychainManager.user, let password = keychainManager.password {
//      webView.stringByEvaluatingJavaScript(from: "loginIfNeeded('\(user)','\(password)');");
//    }
  }
  
  func stateOfSetting(_ id: String) -> Bool? {
    guard let setting = settingWithID(id) else { return nil }
    return setting.isEnabled
  }
  
}
