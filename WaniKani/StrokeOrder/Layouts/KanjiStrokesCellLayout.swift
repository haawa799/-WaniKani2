//
//  KanjiStrokesCellLayout.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class KanjiStrokesCellLayout: UICollectionViewFlowLayout {

    var currentTab: Int = 0
    var numberOfTabs: Int = 0 {
        didSet {
            invalidateLayout()
        }
    }

    private var myItemSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        return collectionView.bounds.size
    }

    override func invalidateLayout() {
        super.invalidateLayout()
    }

    override func prepare() {
        super.prepare()
        sectionInset = .zero
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = myItemSize
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: myItemSize.width * CGFloat(numberOfTabs), height: myItemSize.height)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    func centerToItem() {
        guard let collectionView = collectionView else { return }
        let scrollView = (collectionView as UIScrollView)
        let xShift = CGFloat(currentTab) * myItemSize.width
        scrollView.contentOffset = CGPoint(x: xShift, y: 0)
    }
}
