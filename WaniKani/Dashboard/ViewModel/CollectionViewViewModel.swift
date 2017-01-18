// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation

struct ListCellDataItem {
  let viewModel: ViewModel
  let reuseIdentifier: String
}

struct ListSection {
  let header: ListCellDataItem?
  let items: [ListCellDataItem]
}

public struct ListViewModel {
  
  private let sections: [ListSection]
  
  var notEmpty: Bool {
    if sections.count == 0 {
      return false
    }
    for section in sections {
      if section.items.count == 0 {
        return false
      }
    }
    return true
  }
  
  init(sections: [ListSection]) {
    self.sections = sections
  }
  
  func cellDataItemForIndexPath(indexPath: IndexPath) -> ListCellDataItem? {
    guard sections.count > indexPath.section else { return nil}
    let section = sections[indexPath.section]
    guard section.items.count > indexPath.item else { return nil }
    return section.items[indexPath.item]
  }
  
  func headerItem(section: Int) -> ListCellDataItem? {
    guard sections.count > section else { return nil}
    let section = sections[section]
    return section.header
  }
  
  func numberOfSections() -> Int {
    return sections.count
  }
  
  func numberOfItemsInSection(section: Int) -> Int? {
    guard sections.count > section else { return nil}
    let section = sections[section]
    return section.items.count
  }
}
