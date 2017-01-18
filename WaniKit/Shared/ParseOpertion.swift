// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import PSOperations

public protocol RawResponseProvider: class {
  var rawResponse: RawResponse? { get }
}


public protocol ParseOperationDelegate: class {
  func dataParsed<T>(data: T)
}

public class ParseOperation <T> : PSOperations.Operation {
  
  public weak var rawResponseDataSource: RawResponseProvider?
  public weak var parseDelegate: ParseOperationDelegate?
  
  override public func execute() {
    
    guard let rawResponse = rawResponseDataSource?.rawResponse, let data = rawResponse.data else {
      finish()
      return
    }
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      var array = [[String: AnyObject]]()
      if let dictionary = json as? [String: AnyObject] {
        // JSON root object is dictionary
        array.append(dictionary)
      } else if let jsonArray = json as? [[String: AnyObject]] {
        // JSON root object is array
        array = jsonArray
      }
      if let parsedValues = parsedValue(rootDictionary: array) { parseDelegate?.dataParsed(data: parsedValues) }
      finish()
    }
    catch _ {
      finish()
    }
  }
  
  func parsedValue(rootDictionary: [[String: AnyObject]]) -> T? {
    return nil
  }
  
}
