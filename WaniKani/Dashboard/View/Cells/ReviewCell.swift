//
//  ReviewCell.swift
//  
//
//  Created by Andriy K. on 8/23/15.
//
//

import UIKit

protocol LeftRightTitleDatasource: ViewModel {
  var leftTitle: String { get }
  var rightTitle: String { get }
  var leftTextColor: UIColor { get }
  var rightTextColor: UIColor { get }
}

extension LeftRightTitleDatasource {
  var leftTextColor: UIColor {
    return UIColor.black
  }
  var rightTextColor: UIColor {
    return UIColor.black
  }
}

class ReviewCell: UICollectionViewCell, FlippableView, SingleReuseIdentifier, ViewModelSetupable {

  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!

  func setupWith(_ datasource: LeftRightTitleDatasource) {
    titleLabel?.text = datasource.leftTitle
    numberLabel?.text = datasource.rightTitle
    titleLabel?.textColor = datasource.leftTextColor
    numberLabel?.textColor = datasource.rightTextColor
  }
}

// MARK: - UICollectionViewCell
extension ReviewCell {

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel?.text = nil
    numberLabel?.text = nil
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    prepareForReuse()
  }

}

// MARK: - ViewModelSetupable
extension ReviewCell {
  func setupWithViewModel(_ viewModel: ViewModel?) {
    guard let viewModel = viewModel as? LeftRightTitleDatasource else { return }
    setupWith(viewModel)
  }
}
