//
//  ProgressViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 9/20/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, StoryboardInstantiable {

  @IBOutlet weak var doubleProgressView: DoubleProgressBar!

  func setupWith(progressViewModel: DoubleProgressViewModel) {
    doubleProgressView?.setup(progressViewModel)
  }

}
