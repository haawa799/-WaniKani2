//
//  CookiesStorage.swift
//  WaniKani
//
//  Created by Andriy K. on 3/16/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

struct CookiesStorage {

  private static let key = "cookie"

  static func saveCookies() {
    guard UserDefaults.standard.object(forKey: key) == nil else { return }
    guard let cookies = HTTPCookieStorage.shared.cookies else { return }
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: cookies)
    UserDefaults.standard.set(data, forKey: key)
  }

  static func loadCookies() {
    guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return }
    guard let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HTTPCookie] else { return }
    for c in cookies {
      HTTPCookieStorage.shared.setCookie(c)
    }
  }

  static func clearStoredCookies() {
    UserDefaults.standard.removeObject(forKey: key)
  }
}
