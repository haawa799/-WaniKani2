//
//  SearchItemCellViewModel.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

enum ItemType {
    case radical
    case kanji
    case word
}

struct SearchItemCellViewModel: ViewModel {
    fileprivate let _color: UIColor
    fileprivate let _text: String
    fileprivate let _subTitle: String
    fileprivate let _identifier: String
    fileprivate var _itemType: ItemType
    fileprivate let _imageURL: URL?

    init(kanji: KanjiInfo) {
        _color = UIColor(red:0.89, green:0.09, blue:0.60, alpha:1.00)
        _text = kanji.character
        _identifier = kanji.character
        if let meaning = kanji.meaning {
            _subTitle = meaning.components(separatedBy: ", ").first ?? ""
        } else {
            _subTitle = ""
        }
        _itemType = .kanji
        _imageURL = nil
    }

    init(radical: RadicalInfo) {
        _color = UIColor(red:0.23, green:0.68, blue:0.94, alpha:1.00)
        _text = radical.character ?? ""
        _identifier = radical.character ?? ""
        if let meaning = radical.meaning {
            _subTitle = meaning.components(separatedBy: ", ").first ?? ""
        } else {
            _subTitle = ""
        }
        _itemType = .radical
        if let urlString = radical.image, let url = URL(string: urlString) {
            _imageURL = url
        } else {
            _imageURL = nil
        }
    }

    init(word: WordInfo) {
        _color = UIColor(red:0.63, green:0.14, blue:0.93, alpha:1.00)
        _text = word.character
        _identifier = word.character
        if let meaning = word.meaning {
            _subTitle = meaning.components(separatedBy: ", ").first ?? ""
        } else {
            _subTitle = ""
        }
        _itemType = .word
        _imageURL = nil
    }
}

// MARK: - SearchItemCellDataSource
extension SearchItemCellViewModel: SearchItemCellDataSource {
    var imageURL: URL? {
        return _imageURL
    }

    var subTitle: String {
        return _subTitle
    }

    var identifier: String {
        return _identifier
    }
    var color: UIColor {
        return _color
    }
    var mainText: String {
        return _text
    }
    var itemType: ItemType {
        return _itemType
    }
}
