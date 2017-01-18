//
//  Utils.swift
//
//
//  Created by Andriy K. on 8/25/15.
//
//

import UIKit
//import Device

let hideSubscribitionsSkript = "$('a[href=\"/account/subscription\"]').remove();document.getElementsByClassName('upgrade')[0].remove();document.getElementsByClassName('newbie')[0].remove();"

extension UIBackgroundFetchResult: CustomStringConvertible {
  public var description: String {
    switch self {
    case .newData : return "NewData"
    case .noData : return "NoData"
    case .failed : return "Failed"
    }
  }
}

protocol SingleReuseIdentifier {
  static var identifier: String {get}
  static var nibName: String {get}
}

extension SingleReuseIdentifier where Self: UICollectionReusableView {
  static var identifier: String {
    return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
  }
  static var nibName: String {
    return identifier
  }
}

public protocol FlippableView {
  func flip(_ animations: @escaping () -> Void, delay: TimeInterval)
}

public extension FlippableView where Self: UIView {
  func flip(_ animations: @escaping () -> Void, delay: TimeInterval){
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { 
      UIView.transition(with: self, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromTop, animations: animations, completion: nil)
    }
  }
}

//func optimalReviewMetrics(_ statusBarHidden: Bool) -> (height: Int, width: Int, scale: Int) {
//  let screenSize: CGRect = UIScreen.main.bounds
//  var height = Int(screenSize.height - 154)
//  var scale = 100
//  if statusBarHidden == true {
//    height += 20
//  }
//  let width = Int(screenSize.width)
//  
//  let model = Device.size()
//  
//  var keyboardHeight = 0
//  switch model {
//  case .Screen5_5Inch :
//    keyboardHeight = 271
//    height -= keyboardHeight
//    scale = 250
//  case .Screen4_7Inch :
//    keyboardHeight = 258
//    height -= keyboardHeight
//    scale = 250
//  case .Screen4Inch :
//    keyboardHeight = 258
//    height -= keyboardHeight
//    scale = 220
//  case .Screen3_5Inch :
//    height = 50
//    scale = 100
//  case .Screen7_9Inch, .Screen9_7Inch, .Screen12_9Inch:
//    
//    if UIDevice.current.orientation == .portrait {
//      keyboardHeight = 350
//    } else {
//      keyboardHeight = 455
//    }
//    height -= keyboardHeight
//    scale = 100
//    
//  case .UnknownSize:
//    break
//  }
//  
//  return (height, width, scale)
//}

extension UIView {
  class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T {
    let v: T? = fromNib(nibNameOrNil)
    return v!
  }
  
  class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T? {
    var view: T?
    let name: String
    if let nibName = nibNameOrNil {
      name = nibName
    } else {
      // Most nibs are demangled by practice, if not, just declare string explicitly
      name = "\(T.self)".components(separatedBy: ".").last!
    }
    let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
    for v in nibViews! {
      if let tog = v as? T {
        view = tog
      }
    }
    return view
  }
}

