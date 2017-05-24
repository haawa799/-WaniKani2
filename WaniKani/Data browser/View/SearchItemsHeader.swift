//
//  SearchItemsHeader.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/24/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

protocol SearchItemsHeaderDataSource: ViewModel {
    var title: String { get }
}

class SearchItemsHeader: UICollectionReusableView, SingleReuseIdentifier {

    @IBOutlet weak var label: UILabel!
}

// MARK: - ViewModelSetupable
extension SearchItemsHeader: ViewModelSetupable {
    func setupWithViewModel(_ viewModel: ViewModel?) {
        guard let viewModel = viewModel as? SearchItemsHeaderDataSource else { return }
        label.text = viewModel.title
    }
}
