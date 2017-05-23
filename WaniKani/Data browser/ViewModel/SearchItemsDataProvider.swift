//
//  SearchItemsDataProvider.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import WaniPersistance

protocol SearchItemsDataProviderDelegate: class {
    func newListViewModel(listViewModel: ListViewModel)
}

class SearchItemsDataProvider {

    fileprivate let persistance: Persistance

    init(persistance: Persistance) {
        self.persistance = persistance
    }

    weak var delegate: SearchItemsDataProviderDelegate?

    var searchText: String? {
        didSet {
            let q = persistance.kanjiForLevel(level: 21)
            updateList(items: q)
        }
    }

    fileprivate func updateList(items: [KanjiInfo]) {
        let viewModelItems = items.map { ListCellDataItem(viewModel: SearchItemCellViewModel(kanji: $0), reuseIdentifier: SearchItemCell.identifier) }
        let section = ListSection(header: nil, items: viewModelItems)
        let listViewModel = ListViewModel(sections: [section])
        delegate?.newListViewModel(listViewModel: listViewModel)
    }
}
