//
//  AvaliableItemCell.swift
//
//
//  Created by Andriy K. on 8/19/15.
//
//

import UIKit

protocol AvaliableItemCellDataSource: DisclosureVisibilityData, LeftRightTitleDatasource {}

protocol DisclosureVisibilityData: ViewModel {
  var disclosureVisible: Bool { get }
}

class AvaliableItemCell: UICollectionViewCell, FlippableView, SingleReuseIdentifier, ViewModelSetupable {

  fileprivate struct ConstraintConstant {
    static let expanded: CGFloat = 40
    static let nonExpanded: CGFloat = 22
  }

  @IBOutlet fileprivate weak var disclosureButton: UIButton!
  @IBOutlet fileprivate weak var leftLabel: UILabel!
  @IBOutlet weak var rightLabel: UILabel!
  @IBOutlet weak var rightLabelTrailingConstraint: NSLayoutConstraint!

  func setupWith(_ datasource: AvaliableItemCellDataSource) {
    leftLabel?.text = datasource.leftTitle
    rightLabel?.text = datasource.rightTitle
    leftLabel?.textColor = datasource.leftTextColor
    rightLabel?.textColor = datasource.rightTextColor

    if datasource.disclosureVisible {
      rightLabelTrailingConstraint.constant = ConstraintConstant.expanded
    } else {
      rightLabelTrailingConstraint.constant = ConstraintConstant.nonExpanded
    }
    disclosureButton?.isHidden = !datasource.disclosureVisible
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    leftLabel?.text = nil
    rightLabel?.text = nil
    disclosureButton?.isHidden = true
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    prepareForReuse()
  }
}

// MARK: - ViewModelSetupable
extension AvaliableItemCell {
  func setupWithViewModel(_ viewModel: ViewModel?) {
    guard let viewModel = viewModel as? AvaliableItemCellDataSource else { return }
    setupWith(viewModel)
  }
}
