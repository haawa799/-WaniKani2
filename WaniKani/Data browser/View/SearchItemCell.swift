//
//  SearchItemCell.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel
import Kingfisher

protocol SearchItemCellDataSource: ViewModel {
    var identifier: String { get }
    var color: UIColor { get }
    var mainText: String { get }
    var subTitle: String { get }
    var imageURL: URL? { get }
}

class SearchItemCell: UICollectionViewCell, SingleReuseIdentifier {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var deemView: UIView!

    override var isHighlighted: Bool {
        didSet {
            deemView?.isHidden = !isHighlighted
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHighlighted = false
    }
}

extension SearchItemCell: ViewModelSetupable {
    func setupWithViewModel(_ viewModel: ViewModel?) {
        guard let viewModel = viewModel as? SearchItemCellDataSource else { return }
        containerView.backgroundColor = viewModel.color
        subtitle.text = viewModel.subTitle
        if let url = viewModel.imageURL {
            label.isHidden = true
            imageView.isHidden = false
            imageView.kf.setImage(with: url)
        } else {
            label.isHidden = false
            imageView.isHidden = true
            label.text = viewModel.mainText
        }
    }
}
