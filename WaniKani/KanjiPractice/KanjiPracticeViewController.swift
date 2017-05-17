//
//  KanjiPracticeViewController.swift
//  WaniKani
//
//  Created by Andriy K. on 5/14/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import SwiftyDraw

class KanjiPracticeViewController: UIViewController, StoryboardInstantiable {

  var kanjiStrings = [String]() {
    didSet {
      updateStrokeOrderViewController()
    }
  }
  var strokeOrderViewController: StrokeOrderViewController? {
    didSet {
      updateStrokeOrderViewController()
    }
  }

  @IBOutlet weak var strokeOrderContainer: UIView? {
    didSet {
      guard let strokeOrderContainer = strokeOrderContainer else { return }
      let strokeOrderViewController: StrokeOrderViewController = StrokeOrderViewController.instantiateViewController()
      addChildViewController(strokeOrderViewController)
      strokeOrderContainer.addSubview(strokeOrderViewController.view)
        strokeOrderViewController.view.frame = strokeOrderContainer.bounds
      strokeOrderViewController.view.translatesAutoresizingMaskIntoConstraints = true
      self.strokeOrderViewController = strokeOrderViewController
    }
  }

  @IBOutlet weak var drawingView: SwiftyDrawView! {
    didSet {
      drawingView?.lineColor = UIColor(red:0.99, green:0, blue:0.65, alpha:1)
      drawingView?.lineWidth = 5
    }
  }

  @IBAction func undoAction(sender: AnyObject) {
    drawingView.removeLastLine()
  }

  @IBAction func trashAction(sender: AnyObject) {
    drawingView.clearCanvas()
  }

  fileprivate func updateStrokeOrderViewController() {
    strokeOrderViewController?.kanjiStrings = self.kanjiStrings
  }

}
