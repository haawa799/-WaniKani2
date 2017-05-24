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
            guard let searchText = searchText else { return }
            let results = persistance.searchResults(text: searchText)
            updateList(results: results)
        }
    }

    fileprivate func updateList(results: (radicals: [RadicalInfo], kanji: [KanjiInfo], words: [WordInfo])) {

        var sections = [ListSection]()

        if results.radicals.isEmpty == false {
            let radicalsViewModelItems = results.radicals.map { ListCellDataItem(viewModel: SearchItemCellViewModel(radical: $0), reuseIdentifier: SearchItemCell.identifier) }
            let radicalsHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Radicals"), reuseIdentifier: SearchItemsHeader.identifier)
            let radicalsSection = ListSection(header: radicalsHeader, items: radicalsViewModelItems)
            sections.append(radicalsSection)
        }

        if results.kanji.isEmpty == false {
            let kanjiViewModelItems = results.kanji.map { ListCellDataItem(viewModel: SearchItemCellViewModel(kanji: $0), reuseIdentifier: SearchItemCell.identifier) }
            let kanjiHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Kanji"), reuseIdentifier: SearchItemsHeader.identifier)
            let kanjiSection = ListSection(header: kanjiHeader, items: kanjiViewModelItems)
            sections.append(kanjiSection)
        }

        if results.words.isEmpty == false {
            let wordsViewModelItems = results.words.map { ListCellDataItem(viewModel: SearchItemCellViewModel(word: $0), reuseIdentifier: SearchItemCell.identifier) }
            let wordsHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Words"), reuseIdentifier: SearchItemsHeader.identifier)
            let wordSection = ListSection(header: wordsHeader, items: wordsViewModelItems)
            sections.append(wordSection)
        }

        let listViewModel = ListViewModel(sections: sections)
        delegate?.newListViewModel(listViewModel: listViewModel)
    }
}
