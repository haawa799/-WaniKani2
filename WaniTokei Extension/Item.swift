//
//  Item.swift
//  WaniTokei
//
//  Created by Andriy K. on 8/30/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public enum Item {
  
  struct DictKeys {
    static let type = "type"
    static let kanji = "kanji"
    static let radical = "radical"
    static let word = "vocabulary"
    static let percentage = "percentage"
  }
  
  case kanji(KanjiInfo)
  case word(WordInfo)
  case radical(RadicalInfo)
  
  init?(dictionary: [String : AnyObject]) {
    guard let type = dictionary[DictKeys.type] as? String else { return nil }
    switch type {
    case DictKeys.radical:
      self = Item.radical(RadicalInfo(dict: dictionary))
      return
    case DictKeys.kanji:
      self = Item.kanji(KanjiInfo(dict: dictionary))
      return
    case DictKeys.word:
      self = Item.word(WordInfo(dict: dictionary))
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
  
  public var typeDescription: String {
    switch self {
    case .radical(_): return "radical"
    case .kanji(_): return "kanji"
    case .word(_): return "word"
    }
  }
  
  public var percentage: String? {
    switch self {
    case .radical(let radical): return radical.percentage
    case .kanji(let kanji): return kanji.percentage
    case .word(let word): return word.percentage
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
