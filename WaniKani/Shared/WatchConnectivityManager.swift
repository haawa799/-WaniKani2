//
//  WatchConnectivityManager.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 6/8/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject {

    struct Key {
        static let apiKeyWasSentToWatch = "apiKeyWasSentToWatch"
        static let apiKey = "apiKey"
    }

    var session: WCSession {
        return WCSession.default
    }

    let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
        }
    }

    func sync(statusBlock: @escaping (String) -> Void) {
        session.activate()
        session.sendMessage([Key.apiKey: apiKey], replyHandler: { (_) in
            Defaults.userDefaults.set(true, forKey: Key.apiKeyWasSentToWatch)
            DispatchQueue.main.async {
                statusBlock("API key successfully sent to watch.")
            }
        }) { (_) in
            statusBlock(self.status)
        }
    }

    var status: String {
        if session.isReachable {
            return "Watch reachable"
        } else {
            if session.isWatchAppInstalled {
                return "Watch app installed"
            } else {
                return "Watch app not installed"
            }
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {

    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }

}
