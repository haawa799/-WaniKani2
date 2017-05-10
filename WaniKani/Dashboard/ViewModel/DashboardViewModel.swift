//
//  DashboardViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 9/19/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import WaniModel

struct DashboardViewModel: ViewModel {

  private struct Constants {
    static let firstHeaderTitle = "Available"
    static let secondHeaderTitle = "Reviews"
    static let lessonsTitle = "Lessons"
    static let reviewsTitle = "Reviews"
  }

  let listViewModel: ListViewModel

  init?(dashboardInfo: DashboardInfo) {
    guard let lessonsAvailable = dashboardInfo.studyQueueInfo.lessonsAvaliable,
      let reviewsAvailable = dashboardInfo.studyQueueInfo.reviewsAvaliable,
      let nextHour = dashboardInfo.studyQueueInfo.reviewsNextHour,
      let nextDay = dashboardInfo.studyQueueInfo.reviewsNextDay else {
      return nil
    }

    // Section 0
    let section0 = ListSection(header: nil, items: [])

    // Section 1
    let header1ViewModel = DashboardHeaderViewModel(title: Constants.firstHeaderTitle, color: ColorConstants.dashboardColor)
    let header1Item = ListCellDataItem(viewModel: header1ViewModel, reuseIdentifier: DashboardHeader.nibName)
    let item1_0ViewModel = AvaliableItemCellViewModel(title: Constants.lessonsTitle, number: lessonsAvailable)
    let item1_0 = ListCellDataItem(viewModel: item1_0ViewModel, reuseIdentifier: AvaliableItemCell.nibName)
    let item1_1ViewModel = AvaliableItemCellViewModel(title: Constants.reviewsTitle, number: reviewsAvailable)
    let item1_1 = ListCellDataItem(viewModel: item1_1ViewModel, reuseIdentifier: AvaliableItemCell.nibName)
    let section1 = ListSection(header: header1Item, items: [item1_0, item1_1])

    // Section 2
    let header2ViewModel = DashboardHeaderViewModel(title: Constants.firstHeaderTitle, color: ColorConstants.dashboardColor)
    let header2Item = ListCellDataItem(viewModel: header2ViewModel, reuseIdentifier: DashboardHeader.nibName)
    let waitingString = dashboardInfo.studyQueueInfo.nextReviewDate?.waitingTime()?.string ?? ""
    let item2_0ViewModel = AvaliableItemCellViewModel(title: "Next review", disclosureTitle: waitingString, isDisclosureVisible: false)
    let item2_0 = ListCellDataItem(viewModel: item2_0ViewModel, reuseIdentifier: AvaliableItemCell.nibName)
    let item2_1ViewModel = AvaliableItemCellViewModel(title: "Next hour", disclosureTitle: "\(nextHour)", isDisclosureVisible: false)
    let item2_1 = ListCellDataItem(viewModel: item2_1ViewModel, reuseIdentifier: AvaliableItemCell.nibName)
    let item2_2ViewModel = AvaliableItemCellViewModel(title: "Next day", disclosureTitle: "\(nextDay)", isDisclosureVisible: false)
    let item2_2 = ListCellDataItem(viewModel: item2_2ViewModel, reuseIdentifier: AvaliableItemCell.nibName)
    let section2 = ListSection(header: header2Item, items: [item2_0, item2_1, item2_2])

    listViewModel = ListViewModel(sections: [section0, section1, section2])
  }
}
