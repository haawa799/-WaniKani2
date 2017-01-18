// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class WordListGroupOperation: BaseGetOperation<[WordInfo]> {
  
  private struct Constants {
    static let endpoint = "/vocabulary/"
  }
  
  
  public init(baseURL: URL, level: Int, handler: @escaping DataResponseHandler) {
    
    let urlAddition = "\(Constants.endpoint)\(level)"
    let url = baseURL.appendingPathComponent(urlAddition)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseWordListOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
