//
//  KanjiStrokesCell.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/10/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit
import StrokeDrawingView

class KanjiStrokesCell: UICollectionViewCell, SingleReuseIdentifier {

    var kanji: KanjiGraphicInfo? {
        didSet {
            drawKanji(kanji: kanji)
        }
    }

    @IBOutlet weak var strokesView: StrokeDrawingView? {
        didSet {
            strokesView?.delegate = self
            drawKanji(kanji: kanji)
        }
    }

    private func drawKanji(kanji: KanjiGraphicInfo?) {
        guard let kanji = kanji else { return }
        strokesView?.stopForeverAnimation()
        strokesView?.clean()
        strokesView?.dataSource = kanji
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        strokesView?.stopForeverAnimation()
        strokesView?.clean()
        strokesView?.dataSource = nil
    }

}

// MARK: - StrokeDrawingViewDataDelegate
extension KanjiStrokesCell: StrokeDrawingViewDataDelegate {
    func layersAreNowReadyForAnimation() {
        guard let strokesView = strokesView, strokesView.dataSource != nil else { return }
        strokesView.playForever(delayBeforeEach: 1.3)
    }
}
