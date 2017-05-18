//
//  DashboardHeaderViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/18/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

class DashboardHeaderViewController: UIViewController, StoryboardInstantiable {

    var isVisible = true

    weak var progressViewController: ProgressViewController?
    weak var srsViewController: SRSViewController?

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var progressContainer: UIView! {
        didSet {
            let progressViewController: ProgressViewController = ProgressViewController.instantiateViewController()
            self.addChildViewController(progressViewController)
            progressViewController.view.frame = progressContainer.bounds
            progressViewController.view.translatesAutoresizingMaskIntoConstraints = true
            progressContainer.addSubview(progressViewController.view)
            self.progressViewController = progressViewController
        }
    }
    @IBOutlet weak var srsContainer: UIView! {
        didSet {
            let srsViewController: SRSViewController = SRSViewController.instantiateViewController()
            self.addChildViewController(srsViewController)
            srsViewController.view.frame = srsContainer.bounds
            srsViewController.view.translatesAutoresizingMaskIntoConstraints = true
            srsContainer.addSubview(srsViewController.view)
            self.srsViewController = srsViewController
        }
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let page = CGFloat(pageControl.currentPage)
        scrollView.contentOffset = CGPoint(x: page * scrollView.bounds.width, y: 0)
    }
}

// MARK: - UIScrollViewDelegate
extension DashboardHeaderViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isVisible == true else {
            return
        }
        let progress: CGFloat = scrollView.contentOffset.x / scrollView.bounds.width
        let alpha = 1 - progress
        setStatusBarAlpha(alpha: alpha)
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl?.currentPage = page
    }
}
