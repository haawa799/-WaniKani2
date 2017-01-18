//
//  Item.swift
//  WaniTokei
//
//  Created by Andriy K. on 8/30/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public enum ReviewItemInfo {
  
  struct DictKeys {
    static let type = "type"
    static let kanji = "kanji"
    static let radical = "radical"
    static let word = "vocabulary"
  }
  
  case kanji(KanjiInfo)
  case word(WordInfo)
  case radical(RadicalInfo)
  
  public init?(dict: [String : AnyObject]) {
    guard let type = dict[DictKeys.type] as? String else { return nil }
    switch type {
    case DictKeys.radical:
      self = ReviewItemInfo.radical(RadicalInfo(dict: dict))
      return
    case DictKeys.kanji:
      self = ReviewItemInfo.kanji(KanjiInfo(dict: dict))
      return
    case DictKeys.word:
      self = ReviewItemInfo.word(WordInfo(dict: dict))
      return
    default:
      return nil
    }
  }
  
  public var mainTitle: String {
    switch self {
    case .radical(let radical): return radical.character ?? ""
    case .kanji(let kanji): return kanji.character
    case .word(let word): return word.character
    }
  }
  
  public var percentage: String? {
    switch self {
    case .radical(let radical): return radical.percentage
    case .kanji(let kanji): return kanji.percentage
    case .word(let word): return word.percentage
    }
  }
  
  public var unlockedDate: Date? {
    switch self {
    case .radical(let radical): return radical.unlockedDate
    case .kanji(let kanji): return kanji.unlockedDate
    case .word(let word): return word.unlockedDate
    }
  }
  
  public var meaning: String? {
    switch self {
    case .radical(let radical): return radical.meaning
    case .kanji(let kanji): return kanji.meaning
    case .word(let word): return word.meaning
    }
  }
  
  public var reading: String? {
    switch self {
    case .radical: return ""
    case .kanji(let kanji): return kanji.reading
    case .word(let word): return word.kana
    }
  }
  
  public var backgroundColor: UIColor {
    switch self {
    case .radical(_): return UIColor(red:0.09, green:0.59, blue:0.87, alpha:1.00)
    case .kanji(_): return UIColor(red:0.92, green:0.12, blue:0.39, alpha:1.00)
    case .word(_): return UIColor(red:0.60, green:0.22, blue:0.69, alpha:1.00)
    }
  }
  
}
