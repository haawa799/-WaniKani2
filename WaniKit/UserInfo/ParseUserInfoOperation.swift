// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel


public class ParseUserInfoOperation: ParseOperation<UserInfo> {
  
  static let key = "user_information"
  
  override func parsedValue(rootDictionary: [[String: AnyObject]]) -> UserInfo? {
    guard let rootDictionary = rootDictionary.first else { return nil}
    guard let userInfoDict = rootDictionary[ParseUserInfoOperation.key] as? [String : AnyObject] else { return nil }
    let userInfo = UserInfo(dict: userInfoDict)
    return userInfo
  }
  
}
