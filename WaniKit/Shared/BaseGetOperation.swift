// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import PSOperations

public class BaseGetOperation<T>: GroupOperation, RawResponseProvider, NetworkRequestOperationDelegate, ParseOperationDelegate {
  
  public typealias DataResponseHandler = (T?, NetworkOperationResponseCode?) -> Void
  
  let downloadOperation: NetworkRequestOperation
  let parseOperation: ParseOperation<T>
  
  var completionBlockOperation: Foundation.BlockOperation!
  var downloadResponse: RawResponse?
  var parsedResponse: T?
  
  init(downloadOperation: NetworkRequestOperation, parseOperation: ParseOperation<T>, handler: @escaping DataResponseHandler) {
    
    self.downloadOperation = downloadOperation
    self.parseOperation = parseOperation
    
    super.init(operations: [])
    
    // setup download operation
    downloadOperation.delegate = self
    addOperation(downloadOperation)
    
    // setup parse operation
    parseOperation.rawResponseDataSource = self
    parseOperation.parseDelegate = self
    parseOperation.addDependency(downloadOperation)
    addOperation(parseOperation)
    
    // setup completion
    completionBlockOperation = BlockOperation(block: { (block) in
      handler(self.parsedResponse, self.downloadResponse?.responseCode)
      self.finish()
    })
    completionBlockOperation.addDependency(parseOperation)
    addOperation(completionBlockOperation)
    
  }
  
  public func startExecution() {
    start()
  }
  
}

// RawResponseProvider
public extension BaseGetOperation {
  var rawResponse: RawResponse? {
    return downloadResponse
  }
}

// DownloadOperationDelegate
public extension BaseGetOperation {
  func newResponse(response: RawResponse) {
    downloadResponse = response
  }
}

public extension BaseGetOperation {
  public func dataParsed<K>(data: K) {
    parsedResponse = (data as? T)
  }
}
