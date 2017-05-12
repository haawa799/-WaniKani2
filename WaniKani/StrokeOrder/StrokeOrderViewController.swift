//
//  StrokeOrderViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class StrokeOrderViewController: UIViewController, StoryboardInstantiable {
    var kanji = [KanjiGraphicInfo]() {
        didSet {
            pageControl?.numberOfPages = kanji.count
        }
    }

    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl?.numberOfPages = kanji.count
        }
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            guard let collectionView = collectionView else { return }
            collectionView.register(KanjiStrokesCell.nib, forCellWithReuseIdentifier: KanjiStrokesCell.identifier)
            collectionView.dataSource = self
            collectionView.flashScrollIndicators()
            (collectionView as UIScrollView).delegate = self
        }
    }
}

// MARK: - UICollectionViewDataSource
extension StrokeOrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kanji.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KanjiStrokesCell.identifier, for: indexPath)
        (cell as? KanjiStrokesCell)?.kanji = kanji[indexPath.item]
        return cell
    }
}

// MARK: - 
extension StrokeOrderViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl?.currentPage = page
    }
}
