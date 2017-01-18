// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class StudyQueueGroupOperation: BaseGetOperation<StudyQueueInfo> {
  
  private struct Constants {
    static let endpoint = "/study-queue"
  }
  
  
  public init(baseURL: URL, handler: @escaping DataResponseHandler) {
    
    let url = baseURL.appendingPathComponent(Constants.endpoint)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseStudyQueueOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
