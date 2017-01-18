//
//  User.swift
//  Pods
//
//  Created by Andriy K. on 12/10/15.
//
//

import Foundation

public struct UserInfo {
  
  struct DictionaryKey {
    static let username = "username"
    static let gravatar = "gravatar"
    static let level = "level"
    static let title = "title"
    static let about = "about"
    static let website = "website"
    static let twitter = "twitter"
    static let topicsCount = "topics_count"
    static let postsCount = "posts_count"
    static let creationDate = "creation_date"
  }
  
  public var username: String
  public var gravatar: String?
  public var level: Int?
  public var title: String?
  public var about: String?
  public var website: String?
  public var twitter: String?
  public var topicsCount: Int?
  public var postsCount: Int?
  public var creationDate: Date?
  
}

extension UserInfo {
  
  public init(dict: [String : AnyObject]) {
    username = dict[DictionaryKey.username] as! String
    if let creation = dict[DictionaryKey.creationDate] as? Int {
      creationDate = Date(timeIntervalSince1970: TimeInterval(creation))
    }
    
    gravatar = (dict[DictionaryKey.gravatar] as? String)
    level = (dict[DictionaryKey.level] as? Int)
    title = (dict[DictionaryKey.title] as? String)
    
    about = (dict[DictionaryKey.about] as? String)
    website = (dict[DictionaryKey.website] as? String)
    twitter = (dict[DictionaryKey.twitter] as? String)
    
    topicsCount = (dict[DictionaryKey.topicsCount] as? Int)
    postsCount = (dict[DictionaryKey.postsCount] as? Int)
  }
}
