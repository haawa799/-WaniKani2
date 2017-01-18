// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class SRSDistributionGroupOperation: BaseGetOperation<SRSDistributionInfo> {
  
  private struct Constants {
    static let endpoint = "/srs-distribution"
  }
  
  
  public init(baseURL: URL, handler: @escaping DataResponseHandler) {
    
    let urlAddition = Constants.endpoint
    let url = baseURL.appendingPathComponent(urlAddition)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseSRSDistributionOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
