//
//  ViewController.swift
//  WaniTokei
//
//  Created by Andriy K. on 1/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniLoginKit
import WatchConnectivity

class WatchSyncViewController: UIViewController, StoryboardInstantiable, BluredBackground {

  struct Key {
    static let apiKeyWasSentToWatch = "apiKeyWasSentToWatch"
    static let apiKey = "apiKey"
  }

  @IBOutlet weak var statusLabel: UILabel! {
    didSet {
      let text = apiKeyWasSentToWatch ? "API key successfully sent to watch." : "API key not yet sent to watch."
      statusLabel?.text = text
    }
  }

  @IBAction func syncAction(_ sender: Any) {
    sendApiKey(apiKey: apiKey)
  }

    var apiKey: String?

  var apiKeyWasSentToWatch: Bool {
    return Defaults.userDefaults.bool(forKey: Key.apiKeyWasSentToWatch)
  }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup session
        if WCSession.isSupported() {
            let wcsession = WCSession.default()
            wcsession.delegate = self
            wcsession.activate()
        }

        let item = UIBarButtonItem(title: "Sync", style: .plain, target: self, action: #selector(syncAction(_:)))
        navigationItem.rightBarButtonItem = item
        _ = addBackground(BackgroundOptions.setup.rawValue)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if apiKeyWasSentToWatch == false {
      sendApiKey(apiKey: apiKey)
    }
  }

  func sendApiKey(apiKey: String?) {
    guard let apiKey = apiKey else { return }
    WCSession.default().sendMessage([Key.apiKey: apiKey], replyHandler: { (_) in
      Defaults.userDefaults.set(true, forKey: Key.apiKeyWasSentToWatch)
      DispatchQueue.main.async {
        self.statusLabel?.text = "API key successfully sent to watch."
      }
    }) { (_) in
      self.showSessionStatus(session: WCSession.default())
    }
  }

  func showSessionStatus(session: WCSession) {
    let status: String
    if session.isReachable {
      status = "Watch reachable"
    } else {
      if session.isWatchAppInstalled {
        status = "Watch app installed"
      } else {
        status = "Watch app not installed"
      }
    }
    DispatchQueue.main.async {
      self.statusLabel?.text = status
    }
  }

}

extension WatchSyncViewController: WCSessionDelegate {

    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }

}
