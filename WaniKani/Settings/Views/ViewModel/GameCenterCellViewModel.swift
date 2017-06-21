//
//  GameCenterCellViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 3/28/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

struct GameCenterCellViewModel: GameCenterCollectionViewCellDatasource {

    private let _icon: UIImage?
    private let titleString: String

    init(setting: Setting, icon: UIImage? = nil) {
        titleString = setting.description ?? ""
        _icon = icon
    }

}

extension GameCenterCellViewModel {

    var icon: UIImage? {
        return _icon
    }

    var title: String {
        return titleString
    }

}
