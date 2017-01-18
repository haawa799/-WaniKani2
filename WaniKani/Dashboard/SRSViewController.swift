//
//  SRSViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 9/20/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit

class SRSViewController: UIViewController {

  private var lastSrsViewModel: SRSDistributionViewModel?

  @IBOutlet weak var apprentice: SRSView!
  @IBOutlet weak var guru: SRSView!
  @IBOutlet weak var master: SRSView!
  @IBOutlet weak var enlighten: SRSView!
  @IBOutlet weak var burned: SRSView!

  func update() {
    setupWith(srs: lastSrsViewModel)
  }

  func setupWith(srs: SRSDistributionViewModel?) {
    guard let srs = srs else { return }
    lastSrsViewModel = srs
    apprentice?.setup(srs.apprentice)
    guru?.setup(srs.guru)
    master?.setup(srs.master)
    enlighten?.setup(srs.enlighten)
    burned?.setup(srs.burned)
  }

}

// MARK: - UIViewController
extension SRSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    update()
  }

}
