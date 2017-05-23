//
//  SearchItemCell.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

protocol SearchItemCellDataSource: ViewModel {
    var id: String { get }
    var color: UIColor { get }
    var mainText: String { get }
}

class SearchItemCell: UICollectionViewCell, SingleReuseIdentifier {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var containerView: UIView!
}

extension SearchItemCell: ViewModelSetupable {
    func setupWithViewModel(_ viewModel: ViewModel?) {
        guard let viewModel = viewModel as? SearchItemCellDataSource else { return }
        containerView.backgroundColor = viewModel.color
        label.text = viewModel.mainText
    }
}
