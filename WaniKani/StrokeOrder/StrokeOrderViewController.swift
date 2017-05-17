//
//  StrokeOrderViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class StrokeOrderViewController: UIViewController, StoryboardInstantiable {

    var kanjiStrings = [String]() {
        didSet {
            kanji = kanjiStrings.map { KanjiGraphicInfo(kanji: $0) }
        }
    }

    fileprivate var kanji = [KanjiGraphicInfo]() {
        didSet {
            pageControl?.numberOfPages = kanji.count
            layout.numberOfTabs = kanji.count
        }
    }

    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl?.numberOfPages = kanji.count
        }
    }

    let layout: KanjiStrokesCellLayout = {
        let layout = KanjiStrokesCellLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            guard let collectionView = collectionView else { return }
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.register(KanjiStrokesCell.nib, forCellWithReuseIdentifier: KanjiStrokesCell.identifier)
            collectionView.dataSource = self
            collectionView.flashScrollIndicators()
            (collectionView as UIScrollView).delegate = self
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] (_) in
            self?.layout.centerToItem()
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

// MARK: - UIScrollViewDelegate
extension StrokeOrderViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl?.currentPage = page
        layout.currentTab = page
    }
}
