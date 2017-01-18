// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class CriticalItemsGroupOperation: BaseGetOperation<[ReviewItemInfo]> {
  
  private struct Constants {
    static let endpoint = "/critical-items/"
  }
  
  
  public init(baseURL: URL, maxPercentage: Int, handler: @escaping DataResponseHandler) {
    
    let urlAddition = "\(Constants.endpoint)\(maxPercentage)"
    let url = baseURL.appendingPathComponent(urlAddition)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseCriticalItemsOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
