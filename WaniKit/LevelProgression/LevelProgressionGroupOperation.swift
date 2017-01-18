// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class LevelProgressionGroupOperation: BaseGetOperation<LevelProgressionInfo> {
  
  private struct Constants {
    static let endpoint = "/level-progression"
  }
  
  
  public init(baseURL: URL, handler: @escaping DataResponseHandler) {
    
    let url = baseURL.appendingPathComponent(Constants.endpoint)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseLevelProgressionOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
