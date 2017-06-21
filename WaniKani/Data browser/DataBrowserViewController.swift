//
//  DataBrowserViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/19/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import SHSearchBar

protocol DataBrowserViewControllerDelegate: class {
    func searchTextDidChange(newText: String)
    func searchCancelPressed()
    func itemSelected(reviewItem: ReviewItem)
}

class DataBrowserViewController: UIViewController, BluredBackground, StoryboardInstantiable {

    private let layout: SearchLayout = SearchLayout()

    private var listViewModel = ListViewModel(sections: []) {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegate: DataBrowserViewControllerDelegate?
    var dataSource: ListViewModel? {
        didSet {
            guard let dataSource = dataSource else { return }
            listViewModel = dataSource
        }
    }

    @IBOutlet weak var searchBar: SHSearchBar! {
        didSet {
            let searchGlassIconTemplate = #imageLiteral(resourceName: "icon-search")
            searchBar.textField.leftView = imageViewWithIcon(searchGlassIconTemplate, rasterSize: 11)
            searchBar.textField.leftViewMode = .always
            searchBar.textField.placeholder = "Search text or level number"
            let backgroundColor = UIColor(white: 1.0, alpha: 0.7)
            searchBar.updateBackgroundWith(6, corners: [.allCorners], color: backgroundColor)
            searchBar.layer.shadowColor = UIColor.black.cgColor
            searchBar.layer.shadowOffset = CGSize(width: 0, height: 3)
            searchBar.layer.shadowRadius = 5
            searchBar.layer.shadowOpacity = 0.25
            searchBar.delegate = self
        }
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView?.setCollectionViewLayout(layout, animated: false)
            collectionView?.register(SearchItemsHeader.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SearchItemsHeader.identifier)
            collectionView?.register(SearchItemCell.nib, forCellWithReuseIdentifier: SearchItemCell.identifier)
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }

    private func imageViewWithIcon(_ icon: UIImage, rasterSize: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: 0, y: 0, width: icon.size.width + rasterSize * 2.0, height: icon.size.height)
        imgView.contentMode = .center
        imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        return imgView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = addBackground(BackgroundOptions.data.rawValue)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tap() {
        searchBar.textField.resignFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.totalWidth = min(view.bounds.width, view.bounds.height)
        layout.invalidateLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

// MARK: - UICollectionViewDataSource
extension DataBrowserViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listViewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel.numberOfItemsInSection(section: section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        guard let item = listViewModel.cellDataItemForIndexPath(indexPath: indexPath) else { return cell }
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath)
        (cell as? ViewModelSetupable)?.setupWithViewModel(item.viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = listViewModel.cellDataItemForIndexPath(indexPath: indexPath)?.viewModel as? SearchItemCellViewModel else { return .zero }
        switch item.reviewItem {
            case .kanji, .radical: return layout.kanjiCellSize
            case .word: return layout.wordCellSize
        }
    }

}

// MARK: - UICollectionViewDelegate
extension DataBrowserViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = listViewModel.cellDataItemForIndexPath(indexPath: indexPath)?.viewModel as? SearchItemCellViewModel else { return }
        delegate?.itemSelected(reviewItem: viewModel.reviewItem)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView!
        guard let item = listViewModel.headerItem(section: indexPath.section) else { return header }
        header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: item.reuseIdentifier, for: indexPath)
        (header as? ViewModelSetupable)?.setupWithViewModel(item.viewModel)
        return header
    }
}

// MARK: - SHSearchBarDelegate
extension DataBrowserViewController: SHSearchBarDelegate {
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        delegate?.searchTextDidChange(newText: text)
    }

    func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool {
        searchBar.textField.text = nil
        delegate?.searchCancelPressed()
        return true
    }

    func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool {
        tap()
        return true
    }
}
