//
//  AwardsManager.swift
//  WaniKani
//
//  Created by Andriy K. on 10/21/15.
//  Copyright © 2015 Andriy K. All rights reserved.
//

//wanikani.score.leaderboard.0

import UIKit
import GameKit

enum LevelProgressionStage {
  case PLEASANT
  case PAINFUL
  case DEATH
  case HELL
  case PARADISE
  case REALITY

  var achievementGameCenterID: String {
    let lowerCaseString = "\(self)".lowercased()
    return baseIdentifier + lowerCaseString
  }

  private var baseIdentifier: String {
    return "achievements.lessons."
  }

  private var index: Int {
    switch self {
    case .PLEASANT: return 0
    case .PAINFUL: return 1
    case .DEATH: return 2
    case .HELL: return 3
    case .PARADISE: return 4
    case .REALITY: return 5
    }
  }

  // percentage is value from 1.0 to 100.0
  static func stageForLevel(level: Int) -> (stage: LevelProgressionStage, percentage: Double) {
    var stage: LevelProgressionStage
    var percentage: Double = 1.0
    switch level {
    case  1...10: percentage = (Double(level -  0) / 11 ) * 100; stage = .PLEASANT
    case 11...20: percentage = (Double(level - 10) / 11 ) * 100; stage = .PAINFUL
    case 21...30: percentage = (Double(level - 20) / 11 ) * 100; stage = .DEATH
    case 31...40: percentage = (Double(level - 30) / 11 ) * 100; stage = .HELL
    case 41...50: percentage = (Double(level - 40) / 11 ) * 100; stage = .PARADISE
    case 51...60: percentage = (Double(level - 50) / 11 ) * 100; stage = .REALITY
    default : stage = .PLEASANT
    }
    return (stage, percentage)
  }

  static func stagesLowerThen(level: Int) -> [LevelProgressionStage] {
    let stage = stageForLevel(level: level).stage
    let index = stage.index
    return Array(allValues[0..<index])
  }

  static let allValues = [PLEASANT, PAINFUL, DEATH, HELL, PARADISE, REALITY]
}

class AwardsManager: NSObject {

  private var previousLevelNotSubmitted: Int?

    init(presenter: UIViewController) {
        self.presenter = presenter
        super.init()
    }

  private let player: GKLocalPlayer = GKLocalPlayer.localPlayer()
  private let presenter: UIViewController

  //initiate gamecenter
  func authenticateLocalPlayer() {
    GCHelper.sharedInstance.authenticateLocalUser()
  }

  func resetAchievements() {
    guard player.isAuthenticated == true else {print("not authentificated"); return}
    GKAchievement.resetAchievements(completionHandler: nil)
  }

  private var lastSubmitedLevel = IntUserDefault(key: "lastSubmitedLevel")

  func userLevelUp(oldLevel: Int?, newLevel: Int) {

    guard player.isAuthenticated == true else {print("not authentificated"); return}
    guard lastSubmitedLevel.value != newLevel else {print("level was sumbitted before"); return}

    var achievementsToReport = [GKAchievement]()

    // Unlock older achievements
    let olderStages = LevelProgressionStage.stagesLowerThen(level: newLevel)
    for stage in olderStages {
      let key = stage.achievementGameCenterID
      let achievement = GKAchievement(identifier: key, player: player)
      if achievement.isCompleted == false {
        achievement.showsCompletionBanner = false
        achievement.percentComplete = 100
        achievementsToReport.append(achievement)
      }
    }

    achievementsToReport.last?.showsCompletionBanner = true

    // This stage progress
    let thisStageInfo = LevelProgressionStage.stageForLevel(level: newLevel)
    let thisStage = thisStageInfo.stage
    let percentage = thisStageInfo.percentage
    let key = thisStage.achievementGameCenterID
    let achievement = GKAchievement(identifier: key, player: player)
    if achievement.isCompleted == false {
      achievement.percentComplete = percentage
      achievement.showsCompletionBanner = false
      achievementsToReport.append(achievement)
    }

    lastSubmitedLevel.value = newLevel

    GKAchievement.report(achievementsToReport) { (error) -> Void in
      guard error == nil else {return}
    }

  }

  func showGameCenterViewController() {
    GCHelper.sharedInstance.showGameCenter(presenter, viewState: GKGameCenterViewControllerState.leaderboards)
  }

  //send high score to leaderboard
  func saveHighscore(scoreUpdate: Int) {

    if GKLocalPlayer.localPlayer().isAuthenticated && scoreUpdate > 0 {

      let leaderboard = GKLeaderboard()
      leaderboard.identifier = "wanikani.score.leaderboard.0"
      leaderboard.loadScores(completionHandler: { (score, error) -> Void in
        var oldValue: Int64 = 0
        if score != nil, let localScore = leaderboard.localPlayerScore, error == nil {
          oldValue = localScore.value
        }

        let scoreReporter = GKScore(leaderboardIdentifier: "wanikani.score.leaderboard.0")

        scoreReporter.value = oldValue + Int64(scoreUpdate)

        let scoreArray: [GKScore] = [scoreReporter]

        GKScore.report(scoreArray, withCompletionHandler: { (error) -> Void in
          if let error = error {
            print(error)
          } else {
            let totalReviews = oldValue + Int64(scoreUpdate)
            GKNotificationBanner.show(withTitle: "\(scoreUpdate) reviews recorded", message: "Total reviews: \(totalReviews)", completionHandler: { () -> Void in
              //
            })
          }
        })

      })
    }

  }

}

extension AwardsManager: GKGameCenterControllerDelegate {
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    presenter.dismiss(animated: true, completion: nil)
  }
}
