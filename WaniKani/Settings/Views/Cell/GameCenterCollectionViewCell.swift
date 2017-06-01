//
//  GameCenterCollectionViewCell.swift
//  WaniKani
//
//  Created by Andriy K. on 10/26/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

import UIKit

protocol GameCenterCollectionViewCellDatasource: SingleTitleViewModel {
    var icon: UIImage? { get }
}

class GameCenterCollectionViewCell: UICollectionViewCell, FlippableView, SingleReuseIdentifier, ViewModelSetupable {
  @IBOutlet weak var label: UILabel?
    @IBOutlet weak var button: UIButton?

}

extension GameCenterCollectionViewCell {
  func setupWithViewModel(_ viewModel: ViewModel?) {
    guard let viewModel = viewModel as? GameCenterCollectionViewCellDatasource else { return }
    label?.text = viewModel.title
    button?.setImage(viewModel.icon, for: .normal)
  }
}
