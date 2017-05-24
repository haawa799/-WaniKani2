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
            let level = 21
            let radicals = persistance.radicalsForLevel(level: level)
            let kanji = persistance.kanjiForLevel(level: level)
            let words = persistance.wordsForLevel(level: level)
            updateList(kanji: kanji, words: words, radicals: radicals)
        }
    }

    fileprivate func updateList(kanji: [KanjiInfo], words: [WordInfo], radicals: [RadicalInfo]) {

        var sections = [ListSection]()

        if radicals.isEmpty == false {
            let radicalsViewModelItems = radicals.map { ListCellDataItem(viewModel: SearchItemCellViewModel(radical: $0), reuseIdentifier: SearchItemCell.identifier) }
            let radicalsHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Radicals"), reuseIdentifier: SearchItemsHeader.identifier)
            let radicalsSection = ListSection(header: radicalsHeader, items: radicalsViewModelItems)
            sections.append(radicalsSection)
        }

        if kanji.isEmpty == false {
            let kanjiViewModelItems = kanji.map { ListCellDataItem(viewModel: SearchItemCellViewModel(kanji: $0), reuseIdentifier: SearchItemCell.identifier) }
            let kanjiHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Kanji"), reuseIdentifier: SearchItemsHeader.identifier)
            let kanjiSection = ListSection(header: kanjiHeader, items: kanjiViewModelItems)
            sections.append(kanjiSection)
        }

        if words.isEmpty == false {
            let wordsViewModelItems = words.map { ListCellDataItem(viewModel: SearchItemCellViewModel(word: $0), reuseIdentifier: SearchItemCell.identifier) }
            let wordsHeader = ListCellDataItem(viewModel: SearchItemsHeaderViewModel("Words"), reuseIdentifier: SearchItemsHeader.identifier)
            let wordSection = ListSection(header: wordsHeader, items: wordsViewModelItems)
            sections.append(wordSection)
        }

        let listViewModel = ListViewModel(sections: sections)
        delegate?.newListViewModel(listViewModel: listViewModel)
    }
}
