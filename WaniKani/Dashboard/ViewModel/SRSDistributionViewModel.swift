//
//  SRSDistributionViewModel.swift
//  WaniKani
//
//  Created by Andriy K. on 9/20/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit
import WaniModel

struct SRSDistributionViewModel {

  let apprentice: SRSViewModel
  let guru: SRSViewModel
  let master: SRSViewModel
  let enlighten: SRSViewModel
  let burned: SRSViewModel

  init(srs: SRSDistributionInfo) {
    apprentice = SRSViewModel(srs: srs.apprentice)
    guru = SRSViewModel(srs: srs.guru)
    master = SRSViewModel(srs: srs.master)
    enlighten = SRSViewModel(srs: srs.enlighten)
    burned = SRSViewModel(srs: srs.burned)
  }
}
