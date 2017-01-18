// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class RecentUnlocksGroupOperation: BaseGetOperation<[ReviewItemInfo]> {
  
  private struct Constants {
    static let endpoint = "/recent-unlocks/"
  }
  
  
  public init(baseURL: URL, limit: Int, handler: @escaping DataResponseHandler) {
    
    let urlAddition = "\(Constants.endpoint)\(limit)"
    let url = baseURL.appendingPathComponent(urlAddition)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseRecentUnlocksOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
