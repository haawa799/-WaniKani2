//
//  Defaults.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 6/7/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

class Defaults {
    static let userDefaults: UserDefaults = {
        let label = "WaniKani defaults"
        return UserDefaults(suiteName: label)!
    }()

    static func nuke() {
        let dict = userDefaults.dictionaryRepresentation()
        for key in dict.keys {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }
}
