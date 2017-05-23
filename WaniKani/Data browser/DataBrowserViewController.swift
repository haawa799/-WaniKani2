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
}

class DataBrowserViewController: UIViewController, BluredBackground, StoryboardInstantiable {

    fileprivate var listViewModel = ListViewModel(sections: []) {
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
            searchBar.textField.placeholder = "Example"
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
            collectionView?.dataSource = self
            collectionView?.register(SearchItemCell.nib, forCellWithReuseIdentifier: SearchItemCell.identifier)
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
        return cell
    }
}

// MARK: - SHSearchBarDelegate
extension DataBrowserViewController: SHSearchBarDelegate {
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        delegate?.searchTextDidChange(newText: text)
    }
}
