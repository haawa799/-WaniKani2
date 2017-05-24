//
//  SearchLayout.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/24/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class SearchLayout: UICollectionViewFlowLayout {

    struct Constants {
        static let inset: CGFloat = 15
        static let spacing: CGFloat = 3
        static let maxCellWidth: CGFloat = 80
        static let aspectRatio: CGFloat = 4 / 3
    }

    var totalWidth: CGFloat = 0

    var kanjiCellSize = CGSize.zero
    var wordCellSize = CGSize.zero

    override func prepare() {
        super.prepare()

        sectionInset = UIEdgeInsets(top: 0, left: Constants.inset, bottom: Constants.inset, right: Constants.inset)
        minimumInteritemSpacing = Constants.spacing
        minimumLineSpacing = Constants.spacing

        let kanjiInOneRow: CGFloat = 5
        let sectionInsetHorizontal = sectionInset.left + sectionInset.right
        let kanjiItemSpace = (kanjiInOneRow - 1) * minimumInteritemSpacing
        let allWidth = totalWidth - sectionInsetHorizontal - kanjiItemSpace
        var kanjiWidth = allWidth / kanjiInOneRow
        kanjiWidth = min(kanjiWidth, Constants.maxCellWidth)
        let height = kanjiWidth * Constants.aspectRatio
        kanjiCellSize = CGSize(width: kanjiWidth, height: height)

        let wordsInOneRow: CGFloat = 2
        let wordsItemSpace = (wordsInOneRow - 1) * minimumInteritemSpacing
        let width = collectionView?.bounds.width ?? totalWidth
        let wordCellWidth = (width - sectionInsetHorizontal - wordsItemSpace) / wordsInOneRow
        wordCellSize = CGSize(width: wordCellWidth, height: height)

        headerReferenceSize = CGSize(width: (totalWidth - sectionInsetHorizontal), height: height * 0.5)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }

}
