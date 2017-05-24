//
//  SearchItemCellViewModel.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

struct SearchItemsHeaderViewModel: ViewModel {
    fileprivate let _text: String

    init(_ text: String) {
        _text = text
    }
}

// MARK: - SearchItemsHeaderDataSource
extension SearchItemsHeaderViewModel: SearchItemsHeaderDataSource {
    var title: String {
        return _text
    }
}
