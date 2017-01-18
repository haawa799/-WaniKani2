// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation

public enum NetworkOperationResponseCode: Int {
  
  case Success = 200
  case Failure = 100
  
  public init(code: Int?) {
    guard let code = code else {
      self = .Failure
      return
    }
    switch code {
    case NetworkOperationResponseCode.Success.rawValue: self = .Success
    default: self = .Failure
    }
  }
  
  public func description() -> String {
    switch self {
    case .Failure:         return "Failure"
    case .Success:         return "Success"
    }
  }
}
