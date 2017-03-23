//
//  KanjiProviderPromise.swift
//  WaniKani
//
//  Created by Andriy K. on 3/20/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import Promise

internal class UserInfoProviderPromise: ProviderPromise<UserInfo> {}
internal class LevelProgressionProviderPromise: ProviderPromise<LevelProgressionInfo> {}
internal class ItemsProviderPromise: ProviderPromise<[ReviewItemInfo]> {}
internal class RadicalProviderPromise: ProviderPromise<[RadicalInfo]> {}
internal class KanjiProviderPromise: ProviderPromise<[KanjiInfo]> {}
internal class VocabProviderPromise: ProviderPromise<[WordInfo]> {}
internal class SRSProviderPromise: ProviderPromise<SRSDistributionInfo> {}
internal class StudyQueueProviderPromise: ProviderPromise<StudyQueueInfo> {}
internal class DashboardProviderPromise: ProviderPromise<DashboardInfo> {}
