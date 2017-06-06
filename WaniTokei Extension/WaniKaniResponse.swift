//
//  Item.swift
//  WaniTokei
//
//  Created by Andriy K. on 8/30/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import RealmSwift

public enum RequestedInfo {
  case list([Item])
}

public struct WaniKaniResponse {

  struct DictKeys {
    static let requestedInfo = "requested_information"
    static let userInfo = "user_information"
  }

  public let requestedInfo: RequestedInfo

  public init?(data: Data?) {
    guard let data = data else { return nil }
    guard let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String : AnyObject] else { return nil }
    guard let dictionary = dict else { return nil }
    guard let requested = dictionary[DictKeys.requestedInfo] else { return nil }

    if let array = requested as? [[String : AnyObject]] {
      let items = array.flatMap({ Item(dictionary: $0) })
      requestedInfo = RequestedInfo.list(items)
      return
    }

    return nil
  }

}
