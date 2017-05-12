//
//  KanjiStrokesCellLayout.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class KanjiStrokesCellLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        guard let bounds = collectionView?.bounds else { return }
        itemSize = CGSize(width: bounds.width, height: bounds.height)
        sectionInset = .zero
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
