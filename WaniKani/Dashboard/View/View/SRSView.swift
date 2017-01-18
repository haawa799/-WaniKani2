//
//  SRSView.swift
//  WaniKani
//
//  Created by Andriy K. on 9/20/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit

protocol SRSViewDataSource: ViewModel {
  var topTitle: String { get }
}

class SRSView: UIView, ViewModelSetupable {
  
  @IBOutlet var background: UIView!
  @IBOutlet var topLabel: UILabel!
  @IBOutlet var iconView: UIImageView!
  @IBOutlet var botLabel: UILabel!
  
  func setup(_ datasource: SRSViewDataSource?) {
    guard let datasource = datasource else { return }
    topLabel.text = datasource.topTitle
  }
  
  func setupWithViewModel(_ viewModel: ViewModel?) {
    guard let datasource = viewModel as? SRSViewDataSource else { return }
    setup(datasource)
  }
  
}
