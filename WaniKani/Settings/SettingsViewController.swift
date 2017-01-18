//
//  SettingsViewController.swift
//
//
//  Created by Andriy K. on 9/13/15.
//
//

import UIKit
import GameKit

protocol SettingsViewControllerDelegate: class {
  func cellPressed(_ indexPath: IndexPath)
  func cellCheckboxStateChange(identifier: String, state: Bool)
}

class SettingsViewController: SingleTabViewController, StoryboardInstantiable, BluredBackground {

  weak var delegate: SettingsViewControllerDelegate?

  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView?.dataSource = self
      collectionView?.delegate = self
      collectionView?.alwaysBounceVertical = true
      let scriptCell = UINib(nibName: "SettingsScriptCell", bundle: nil)
      collectionView?.register(scriptCell, forCellWithReuseIdentifier: SettingsScriptCell.identifier)
      let gameCenterCell = UINib(nibName: "GameCenterCollectionViewCell", bundle: nil)
      collectionView?.register(gameCenterCell, forCellWithReuseIdentifier: GameCenterCollectionViewCell.identifier)
      let headerNib = UINib(nibName: "DashboardHeader", bundle: nil)
      collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DashboardHeader.identifier)
    }
  }

  fileprivate var collectionViewModel: ListViewModel?

  var settingSuit: SettingsSuit? {
    didSet {
      collectionViewModel = settingSuit?.collectionViewViewModel
      collectionView?.reloadData()
    }
  }
}

// MARK: - UIViewController
extension SettingsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let _ = addBackground(BackgroundOptions.Dashboard.rawValue)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.reloadData()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView?.collectionViewLayout.invalidateLayout()
  }
}

extension SettingsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.cellPressed(indexPath)
  }
}

extension SettingsViewController: UICollectionViewDataSource {

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
    if let cell = cell as? SettingsScriptCell {
      cell.delegate = self
      if let dataSource = item.viewModel as? SettingsScriptCellViewModel {
        let id = dataSource.scriptID
        if let state = settingSuit?.stateOfSetting(identifier: id) {
          cell.setupWith(dataSource, state: state)
        }
      }
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    guard let _ = collectionViewModel?.headerItem(section: section) else { return CGSize.zero }
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
    return flowLayout.headerReferenceSize
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    var header: UICollectionReusableView!
    guard let item = collectionViewModel?.headerItem(section: (indexPath as NSIndexPath).section) else { return header }
    header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: item.reuseIdentifier, for: indexPath)
    (header as? ViewModelSetupable)?.setupWithViewModel(item.viewModel)
    guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return header }
    let size = self.collectionView(collectionView, layout: flowLayout, referenceSizeForHeaderInSection: (indexPath as NSIndexPath).section)
    (header as? DashboardHeader)?.resize(size.width)
    return header
  }
}

extension SettingsViewController: SettingsScriptCellDelegate {

  func scriptCellChangedState(_ cell: SettingsScriptCell, state: Bool) {
    guard let identifier = cell.identifier else { return }
    delegate?.cellCheckboxStateChange(identifier: identifier, state: state)
  }
}
