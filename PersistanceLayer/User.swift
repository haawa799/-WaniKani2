//
//  User.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {

  dynamic var levelProgression: LevelProgressionInfo?
  dynamic var studyQueue: StudyQueueInfo?
  dynamic var srs: SRSDistributionInfo?

  dynamic var criticalItems: ReviewItemsList?
  dynamic var recentsItems: ReviewItemsList?
  dynamic var apiKey: String = ""

  convenience init(apiKey: String) {
    self.init()
    self.apiKey = apiKey
  }

}
