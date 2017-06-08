//
//  ViewController.swift
//  WaniTokei
//
//  Created by Andriy K. on 1/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import WaniLoginKit

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
    sync()
  }

    func sync() {
        connectivityManager?.sync(statusBlock: { [weak self] (status) in
            self?.statusLabel?.text = status
        })
    }

    var connectivityManager: WatchConnectivityManager?

  var apiKeyWasSentToWatch: Bool {
    return Defaults.userDefaults.bool(forKey: Key.apiKeyWasSentToWatch)
  }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup session
        sync()

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
      sync()
    }
  }

}
