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

class DataBrowserCoordinator: NSObject, Coordinator {

  struct Constant {
    static let defaultsDownloadKey = "defaultsDownloadKey"
  }

  fileprivate let presenter: UINavigationController
  fileprivate let dataProvider: DataProvider
  fileprivate let searchDataProvider: SearchItemsDataProvider
  fileprivate weak var dataBrowserViewController: DataBrowserViewController?
  fileprivate var downloadingCoordinator: DownloadingCoordinator?

  init(presenter: UINavigationController, persistance: Persistance, dataProvider: DataProvider) {
    self.presenter = presenter
    self.dataProvider = dataProvider
    self.searchDataProvider = SearchItemsDataProvider(persistance: persistance)
    super.init()
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

  fileprivate func showRadical(radical: RadicalInfo) {
    let radicalViewController: RadicalDetailViewController = RadicalDetailViewController.instantiateViewController()
    radicalViewController.radical = radical
    radicalViewController.navigationItem.title = radical.character
    presenter.pushViewController(radicalViewController, animated: true)
  }

  fileprivate func showWord(word: WordInfo) {
    let wordDetailViewController: WordDetailViewController = WordDetailViewController.instantiateViewController()
    wordDetailViewController.word = word
    wordDetailViewController.navigationItem.title = word.character
    presenter.pushViewController(wordDetailViewController, animated: true)
  }
}

// MARK: - Coordinator
extension DataBrowserCoordinator {
  func start() {

    let noData = UserDefaults.standard.bool(forKey: Constant.defaultsDownloadKey)

    if noData == true {
      presentDataBrowser(push: false)
    } else {
      let downloadingCoordinator = DownloadingCoordinator(presenter: presenter, dataProvider: dataProvider)
      downloadingCoordinator.delegate = self
      downloadingCoordinator.start()
      self.downloadingCoordinator = downloadingCoordinator
    }
  }

  func presentDataBrowser(push: Bool) {
    let dataBrowserViewController: DataBrowserViewController = DataBrowserViewController.instantiateViewController()
    _ = dataBrowserViewController.view
    if presenter.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
      dataBrowserViewController.registerForPreviewing(with: self, sourceView: dataBrowserViewController.view)
    }
    dataBrowserViewController.delegate = self
    presenter.isNavigationBarHidden = true

    if push == true {
      presenter.pushViewController(dataBrowserViewController, animated: false)
    } else {
      presenter.setViewControllers([dataBrowserViewController], animated: true)
    }
    self.dataBrowserViewController = dataBrowserViewController
  }

}

// MARK: - SearchItemsDataProviderDelegate
extension DataBrowserCoordinator: SearchItemsDataProviderDelegate {
  func newListViewModel(listViewModel: ListViewModel) {
    dataBrowserViewController?.dataSource = listViewModel
  }
}

// MARK: - UIViewControllerPreviewingDelegate
extension DataBrowserCoordinator: UIViewControllerPreviewingDelegate {
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    guard let dataBrowserViewController = dataBrowserViewController else { return nil }
    let location = dataBrowserViewController.view.convert(location, to: dataBrowserViewController.collectionView)
    guard let indexPath = dataBrowserViewController.collectionView?.indexPathForItem(at: location) else { return nil }
    guard let cell = dataBrowserViewController.collectionView?.cellForItem(at: indexPath) else { return nil }
    guard let item = dataBrowserViewController.dataSource?.cellDataItemForIndexPath(indexPath: indexPath)?.viewModel as? SearchItemCellViewModel else { return nil }

    var viewController: UIViewController?

    switch item.reviewItem {
    case .kanji(let kanji):
      let kanjiViewController: KanjiDetailViewController = KanjiDetailViewController.instantiateViewController()
      kanjiViewController.kanji = kanji
      let previewHeight = kanjiViewController.view.bounds.width + 15
      kanjiViewController.preferredContentSize = CGSize(width: 0.0, height: previewHeight)
      viewController = kanjiViewController
    case .radical(let radical):
      let radicalViewController: RadicalDetailViewController = RadicalDetailViewController.instantiateViewController()
      radicalViewController.radical = radical
      radicalViewController.navigationItem.title = radical.character
      let previewHeight = radicalViewController.view.bounds.width * 0.5 + 15
      radicalViewController.preferredContentSize = CGSize(width: 0.0, height: previewHeight)
      viewController = radicalViewController
    case .word(let word):
      let wordDetailViewController: WordDetailViewController = WordDetailViewController.instantiateViewController()
      wordDetailViewController.word = word
      wordDetailViewController.navigationItem.title = word.character
      let previewHeight = wordDetailViewController.view.bounds.width * 0.75 + 15
      wordDetailViewController.preferredContentSize = CGSize(width: 0.0, height: previewHeight)
      previewingContext.sourceRect = cell.frame
      viewController = wordDetailViewController
    }
    return viewController
  }

  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    presenter.pushViewController(viewControllerToCommit, animated: true)
  }
}

// MARK: - DataBrowserViewControllerDelegate
extension DataBrowserCoordinator: DataBrowserViewControllerDelegate {
  func itemSelected(reviewItem: ReviewItem) {
    switch reviewItem {
    case .kanji(let kanji): showKanji(kanji: kanji)
    case .radical(let radical): showRadical(radical: radical)
    case .word(let word): showWord(word: word)
    }
  }

  func searchTextDidChange(newText: String) {
    searchDataProvider.searchText = newText
  }

  func searchCancelPressed() {
    searchDataProvider.searchText = nil
  }
}

// MARK: - DownloadingCoordinatorDelegate
extension DataBrowserCoordinator: DownloadingCoordinatorDelegate {
  func downloadComplete() {
    UserDefaults.standard.set(true, forKey: Constant.defaultsDownloadKey)
    presentDataBrowser(push: false)
  }

}
