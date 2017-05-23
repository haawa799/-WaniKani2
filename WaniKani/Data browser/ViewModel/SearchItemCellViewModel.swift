//
//  SearchItemCellViewModel.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/22/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniModel

struct SearchItemCellViewModel: ViewModel {
    fileprivate var _color: UIColor
    fileprivate var _text: String
    fileprivate var _identifier: String

    init(kanji: KanjiInfo) {
        _color = .blue
        _text = kanji.character
        _identifier = kanji.character
    }
}
