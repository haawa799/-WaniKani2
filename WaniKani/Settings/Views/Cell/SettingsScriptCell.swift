//
//  SettingsScriptCell.swift
//  WaniKani
//
//  Created by Andriy K. on 9/23/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit

protocol SettingsScriptCellDataSource: SingleTitleViewModel {
  var scriptID: String { get }
  var switchState: Bool { get }
}

protocol SettingsScriptCellDelegate: class {
  func scriptCellChangedState(_ cell: SettingsScriptCell ,state: Bool)
}

class SettingsScriptCell: UICollectionViewCell, FlippableView, SingleReuseIdentifier {
  
  weak var delegate: SettingsScriptCellDelegate?
  var id: String?
  
  @IBOutlet fileprivate weak var titleLabel: UILabel!
  @IBOutlet fileprivate weak var flatSwitch: AIFlatSwitch!
  
  @objc @IBAction fileprivate func switchValueChanged(_ sender: AIFlatSwitch) {
    delegate?.scriptCellChangedState(self, state: sender.isSelected)
  }
  
  func setupWith(_ dataSource: SettingsScriptCellDataSource, state: Bool) {
    titleLabel.text = dataSource.title
    flatSwitch.isSelected = state
    id = dataSource.scriptID
  }
  
}
