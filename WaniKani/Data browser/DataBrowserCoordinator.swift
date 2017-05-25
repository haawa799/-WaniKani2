//
//  DataBrowserCoordinator.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/19/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniPersistance
import WaniModel

class DataBrowserCoordinator: Coordinator {

    fileprivate let presenter: UINavigationController
    fileprivate let searchDataProvider: SearchItemsDataProvider
    fileprivate weak var dataBrowserViewController: DataBrowserViewController?

    init(presenter: UINavigationController, persistance: Persistance) {
        self.presenter = presenter
        self.searchDataProvider = SearchItemsDataProvider(persistance: persistance)
        searchDataProvider.delegate = self
        let tabItem: UITabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "icon-search"), selectedImage: nil)
        presenter.tabBarItem = tabItem
    }

    fileprivate func showKanji(kanji: KanjiInfo) {
        let kanjiViewController: KanjiDetailViewController = KanjiDetailViewController.instantiateViewController()
        kanjiViewController.kanji = kanji
        kanjiViewController.navigationItem.title = kanji.character
        presenter.pushViewController(kanjiViewController, animated: true)
    }
}

// MARK: - Coordinator
extension DataBrowserCoordinator {
    func start() {
        let dataBrowserViewController: DataBrowserViewController = DataBrowserViewController.instantiateViewController()
        dataBrowserViewController.delegate = self
        presenter.isNavigationBarHidden = true
        presenter.pushViewController(dataBrowserViewController, animated: false)
        self.dataBrowserViewController = dataBrowserViewController
    }
}

// MARK: - SearchItemsDataProviderDelegate
extension DataBrowserCoordinator: SearchItemsDataProviderDelegate {
    func newListViewModel(listViewModel: ListViewModel) {
        dataBrowserViewController?.dataSource = listViewModel
    }
}

// MARK: - DataBrowserViewControllerDelegate
extension DataBrowserCoordinator: DataBrowserViewControllerDelegate {
    func itemSelected(reviewItem: ReviewItem) {
        switch reviewItem {
        case .kanji(let kanji): showKanji(kanji: kanji)
        default: break
        }
    }

    func searchTextDidChange(newText: String) {
        searchDataProvider.searchText = newText
    }

    func searchCancelPressed() {
        searchDataProvider.searchText = nil
    }
}
