//
//  StrokeOrderViewController.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import KanjiBezierPaths

class StrokeOrderViewController: UIViewController, StoryboardInstantiable {

    fileprivate let kanjiProvider = KanjiProvider()

    var kanji = [String]() {
        didSet {
            self.kanjiBezierPathes = kanji.flatMap { kanjiProvider.pathesForKanji($0) }
        }
    }

    fileprivate var kanjiBezierPathes = [[UIBezierPath]]() {
        didSet {
            debugPrint(kanjiBezierPathes)
        }
    }
}
