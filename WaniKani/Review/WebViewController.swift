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

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    settingsSuit?.applyResizingScriptsToWebView(webView, type: type)
  }

}
