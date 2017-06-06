//
//  ExtensionDelegate.swift
//  WaniTokei WatchKit Extension
//
//  Created by Andriy K. on 8/29/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import WatchKit
import WatchConnectivity
import TokeiModel

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
  
  func applicationDidFinishLaunching() {
    WCSession.default().delegate = self
    WCSession.default().activate()
  }
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    let key = "apiKey"
    guard let apiKey = message[key] else { return }
    UserDefaults.standard.setValue(apiKey, forKey: key)
    replyHandler([:])
  }
  
}
