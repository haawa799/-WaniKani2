//
//  WebViewController.swift
//
//
//  Created by Andriy K. on 8/26/15.
//
//

import UIKit

protocol WebViewControllerDelegate: class {
  func webViewControllerBecomeReadyForLoad(viewController: WebViewController)
}

class WebViewController: UIViewController, StoryboardInstantiable {

  fileprivate var settingsSuit: SettingsSuit?
  fileprivate var lastSize = CGSize.zero

  // Public API:
  convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, settingsSuit: SettingsSuit?) {
    self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.settingsSuit = settingsSuit
  }

  weak var delegate: WebViewControllerDelegate?

  func loadReviews(_ type: WebSessionType) {
    self.type = type
    if let realURL = URL(string: type.url) {
      let request = URLRequest(url: realURL)
      webView?.loadRequest(request)
      webView?.keyboardDisplayRequiresUserAction = false
    }
  }

  fileprivate var type = WebSessionType.lesson

  fileprivate var newScoreEarned = 0
  fileprivate var oldOffset: CGFloat?
  fileprivate var ignoreResizing = false

  @IBOutlet weak var webView: UIWebView! {
    didSet {
      webView.accessibilityIdentifier = "WebView"
      webView.delegate = self
      delegate?.webViewControllerBecomeReadyForLoad(viewController: self)
    }
  }

  func character() -> String? {
    if let response = webView.stringByEvaluatingJavaScript(from: "getCharacter();") {
      return response
    }
    return nil
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(background), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(foreground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }

  func foreground() {
    ignoreResizing = false
  }

  func background() {
    ignoreResizing = true
  }
}

extension WebViewController: UIWebViewDelegate {

  fileprivate func checkForNewScore() {
    if let response = webView.stringByEvaluatingJavaScript(from: "getScore();"),
      let score = Int(response), score != 0 {
        newScoreEarned += score
    }
  }

  fileprivate func submitScore() {
    //AwardsManager.sharedInstance.saveHighscore(newScoreEarned)
  }

  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if type.url.contains(request.url!.absoluteString) {
      checkForNewScore()
      return true
    } else {
      return request.url!.absoluteString == "https://www.wanikani.com/login"
    }
  }

  func webViewDidFinishLoad(_ webView: UIWebView) {
    SettingsSuit.applyUserScriptsToWebView(webView, type: type)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    defer { lastSize = size    }
    guard size.width != lastSize.width else { return }
    guard ignoreResizing == false else { return }
    coordinator.animateAlongsideTransition(in: nil, animation: nil) { (_) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        self.settingsSuit?.applyResizingScriptsToWebView(size: size, webView: self.webView, type: self.type)
      }
    }
  }

}
