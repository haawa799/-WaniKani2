//
//  ViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 8/11/15.
//  Copyright (c) 2015 Andriy K. All rights reserved.
//

import UIKit
import DGElasticPullToRefreshKit
import EMPageViewController

protocol DashboardViewControllerDelegate: class {
  func dashboardPullToRefreshAction()
  func didSelectCell(_ indexPath: IndexPath)
}

class DashboardViewController: SingleTabViewController, StoryboardInstantiable, UICollectionViewDelegate, EMPageViewControllerDataSource, EMPageViewControllerDelegate {

  // MARK: Outlets
  @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var doubleProgressBar: DoubleProgressBar!
  @IBOutlet weak var topView: UIView!

  fileprivate let srsVC: SRSViewController = DashboardViewController.instantiateViewController("srs", nil)
  fileprivate let progressVC: ProgressViewController = DashboardViewController.instantiateViewController("progress", nil)
  fileprivate var pageViewController: EMPageViewController?

  @IBOutlet fileprivate weak var collectionView: UICollectionView! {
    didSet {
      collectionView?.alwaysBounceVertical = true
      collectionView?.dataSource = self
      collectionView?.delegate = self
      let avaliableCellNib = UINib(nibName: AvaliableItemCell.nibName, bundle: nil)
      collectionView?.register(avaliableCellNib, forCellWithReuseIdentifier: AvaliableItemCell.identifier)
      let headerNib = UINib(nibName: DashboardHeader.nibName, bundle: nil)
      collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DashboardHeader.identifier)
    }
  }

  // MARK: Public API
  weak var delegate: DashboardViewControllerDelegate?

  func updateDashboardWithViewModels(progressViewModel: DoubleProgressViewModel, collectionViewModel: ListViewModel, srsViewModel: SRSDistributionViewModel, isOld: Bool = false) {
    srsVC.setupWith(srs: srsViewModel)
    progressVC.setupWith(progressViewModel: progressViewModel)
    self.collectionViewModel = collectionViewModel
    reloadCollectionView((isOld==false))
  }

  func endLoadingIfNeeded() {
    if isPulledDown == true {
      isPulledDown = false
      collectionView.dg_stopLoading()
    }
  }

  // MARK: Private
  fileprivate var collectionViewModel: ListViewModel?
  fileprivate var isHeaderShrinked = false
  fileprivate var isPulledDown = false
  fileprivate var stratchyLayout: DashboardLayout? {
    return collectionView.collectionViewLayout as? DashboardLayout
  }

}

extension DashboardViewController {

  func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    guard viewController !=  srsVC else { return nil }
    return srsVC
  }

  func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    guard viewController !=  progressVC else { return nil }
    return progressVC
  }
}

// MARK: - EMPageViewControllerDelegate
extension DashboardViewController {

  func em_pageViewController(_ pageViewController: EMPageViewController, isScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController, progress: CGFloat) {
    let prg: CGFloat = abs(progress)
    let alpha: CGFloat
    if startingViewController == progressVC {
      alpha = 1 - prg
    } else {
      alpha = prg
    }
    setStatusBarAlpha(alpha: alpha)
  }
}

// MARK: - SingleTabViewController
extension DashboardViewController {

  override func didShrink() {
    super.didShrink()
    headerHeightConstraint.constant = 0
  }

  override func didUnshrink() {
    super.didUnshrink()
    refreshProgressConstraint()
  }

}

// MARK: - UICollectionViewDataSource
extension DashboardViewController : UICollectionViewDataSource, BluredBackground {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    guard let collectionViewModel = collectionViewModel else { return 0 }
    return collectionViewModel.numberOfSections()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionViewModel?.numberOfItemsInSection(section: section) ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell: UICollectionViewCell!
    guard let item = collectionViewModel?.cellDataItemForIndexPath(indexPath: indexPath) else { return cell }
    cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath)
    (cell as? ViewModelSetupable)?.setupWithViewModel(item.viewModel)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    guard collectionViewModel?.headerItem(section: section) != nil else { return CGSize.zero }
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
    return flowLayout.headerReferenceSize
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    var header: UICollectionReusableView!
    guard let item = collectionViewModel?.headerItem(section: indexPath.section) else { return header }
    header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: item.reuseIdentifier, for: indexPath)
    (header as? ViewModelSetupable)?.setupWithViewModel(item.viewModel)
    guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return header }
    let size = self.collectionView(collectionView, layout: flowLayout, referenceSizeForHeaderInSection: (indexPath as NSIndexPath).section)
    (header as? DashboardHeader)?.resize(size.width)
    return header
  }

  @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelectCell(indexPath)
  }

}

// MARK: - UIViewController
extension DashboardViewController {

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView?.collectionViewLayout.invalidateLayout()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    _ = addBackground(BackgroundOptions.dashboard.rawValue)
    addPullToRefresh()
    refreshProgressConstraint()

    let pageViewController = EMPageViewController(navigationOrientation: .horizontal)
    pageViewController.dataSource = self
    pageViewController.delegate = self

    pageViewController.selectViewController(progressVC, direction: .forward, animated: false, completion: nil)
    self.addChildViewController(pageViewController)
    pageViewController.view.frame = topView.bounds
    self.topView.addSubview(pageViewController.view)
    pageViewController.didMove(toParentViewController: self)
    self.pageViewController = pageViewController
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let top = self.topLayoutGuide.length
    let bottom = self.bottomLayoutGuide.length
    let newInsets = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    self.collectionView.contentInset = newInsets
    collectionView.reloadData()
  }

}

// MARK: - Private functions
extension DashboardViewController {

  fileprivate func addPullToRefresh() {
    let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
    collectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
      // Add your logic here
      self?.isPulledDown = true
      self?.delegate?.dashboardPullToRefreshAction()
      }, loadingView: loadingView)
    let fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
    collectionView.dg_setPullToRefreshFillColor(fillColor)
    collectionView.dg_setPullToRefreshBackgroundColor(UIColor.clear)
  }

  fileprivate func reloadCollectionView(_ flipCells: Bool) {
    endLoadingIfNeeded()
    if flipCells {
      flipVisibleCells()
    }
    collectionView?.reloadData()
  }

  fileprivate func reloadProgressBarProgression(_ viewModel: DoubleProgressViewModel?) {
    guard let viewModel = viewModel else { return }
    doubleProgressBar?.setup(viewModel)
  }

  fileprivate func flipVisibleCells() {
    var delayFromFirst: Float = 0.0
    let deltaTime: Float = 0.1
    guard let cells = collectionView?.visibleCells else { return }
    for cell in cells {
      delayFromFirst += deltaTime
      (cell as? FlippableView)?.flip({
        }, delay: TimeInterval(delayFromFirst))
    }
  }

  func refreshProgressConstraint() {
    headerHeightConstraint.constant = view.bounds.height * 0.15
  }

}

extension DashboardViewController {

  override var canBecomeFirstResponder: Bool {
    return true
  }

  override var keyCommands: [UIKeyCommand]? {
    if #available(iOS 9.0, *) {
      return [
        UIKeyCommand(input: "1", modifierFlags: .command, action: #selector(itemSelected(_:)), discoverabilityTitle: "Lessons"),
        UIKeyCommand(input: "2", modifierFlags: .command, action: #selector(itemSelected(_:)), discoverabilityTitle: "Reviews")
      ]
    } else {
      // Fallback on earlier versions
      return [
        UIKeyCommand(input: "1", modifierFlags: .command, action: #selector(itemSelected(_:))),
        UIKeyCommand(input: "2", modifierFlags: .command, action: #selector(itemSelected(_:)))
      ]
    }
  }

  func itemSelected(_ sender: UIKeyCommand) {
    guard let index = Int(sender.input) else { return }
    let indexPath = IndexPath(row: index - 1, section: 1)
    delegate?.didSelectCell(indexPath)
  }

}
