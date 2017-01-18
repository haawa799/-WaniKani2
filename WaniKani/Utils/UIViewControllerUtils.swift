//✅
//  UIViewControllerUtils.swift
//  WaniKani
//
//  Created by Andriy K. on 3/14/16.
//  Copyright © 2016 Andriy K. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
  static func instantiateViewController<T>(_ bundle: Bundle?) -> T
  static func instantiateViewController<T>(_ identifier: String, _ bundle: Bundle?) -> T
  static var defaultFileName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {

  static var defaultFileName: String {
    return NSStringFromClass(Self.self).components(separatedBy: ".").last!
  }
  
  static func instantiateViewController<T>(_ bundle: Bundle? = nil) -> T {
    let fileName = defaultFileName
    let sb = UIStoryboard(name: fileName, bundle: bundle)
    return sb.instantiateInitialViewController() as! T
  }
  
  static func instantiateViewController<T>(_ identifier: String, _ bundle: Bundle? = nil) -> T {
    let fileName = defaultFileName
    let sb = UIStoryboard(name: fileName, bundle: bundle)
    return sb.instantiateViewController(withIdentifier: identifier) as! T
  }
  
}
