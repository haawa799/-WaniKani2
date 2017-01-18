// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import PSOperations
import WaniModel

public class AllKanjiGroupOperation: PSOperations.GroupOperation {
  
  static let levels: [Int] = {
    var lvls = [Int]()
    lvls += 1...60
    return lvls
  }()
  
  private var allKanji: [Int : [KanjiInfo]] = {
    var all = [Int : [KanjiInfo]]()
    for level in levels {
      all[level] = [KanjiInfo]()
    }
    return all
  }()
  
  public init(baseURL: URL, handler: @escaping ([Int : [KanjiInfo]]) -> Void) {
    
    super.init(operations: [])
    
    let completionOperation = PSOperations.BlockOperation { ( _ ) in
      handler(self.allKanji)
    }
    
    for level in AllKanjiGroupOperation.levels {
      let kanjiOperation = KanjiListGroupOperation(baseURL: baseURL, level: level, handler: { (kanji, responseCode) in
        guard let kanji = kanji else { return }
        self.allKanji[level]?.append(contentsOf: kanji)
      })
      completionOperation.addDependency(kanjiOperation)
      addOperation(kanjiOperation)
    }
    
    addOperation(completionOperation)
  }
}
