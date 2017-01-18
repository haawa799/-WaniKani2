//
//  QQQ.swift
//  WatchKit
//
//  Created by Andriy K. on 9/9/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation
import PSOperations

public enum NetworkRequestMethod: String {
  case GET
}

public enum Result<T, U> {
  case Response(() -> T)
  case Error(() -> U)
}


public typealias RawResponse = (data: Data?, responseCode: NetworkOperationResponseCode)

public protocol NetworkRequestOperationDelegate: class {
  func newResponse(response: RawResponse)
}

public class NetworkRequestOperation: GroupOperation {
  
  public weak var delegate: NetworkRequestOperationDelegate?
  
  init(requestMethod: NetworkRequestMethod = .GET,
       url: URL) {
    
    super.init(operations: [])
    
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    var request = URLRequest(url: url)
    
    
    request.httpMethod = requestMethod.rawValue
    
    
    let task = session.downloadTask(with: request) { (url, response, error) -> Void in
      
      // Get data from cache
      var data: Data? = nil
      if let url = url { data = try? Data(contentsOf: url) }
      
      // Check for different responses
      guard let response = response as? HTTPURLResponse else { return }
      let responseCode = NetworkOperationResponseCode(code: response.statusCode)
      if responseCode != .Success {
        data = nil
      }
      // Call delegate with collected data and response code
      self.delegate?.newResponse(response: (data, responseCode))
    }
    
    let taskOperation = URLSessionTaskOperation(task: task)
    addOperation(taskOperation)
  }
  
  public override func execute() {
    super.execute()
    print(":")
  }
  
}
