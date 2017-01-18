// Copyright (c) 2016 Lebara. All rights reserved.
// Author:  Andrew Kharchyshyn <akharchyshyn@gmail.com>

import Foundation
import WaniModel

public class UserInfoGroupOperation: BaseGetOperation<UserInfo> {
  
  private struct Constants {
    static let endpoint = "/user-information"
  }
  
  
  public init(baseURL: URL, handler: @escaping DataResponseHandler) {
    
    let url = baseURL.appendingPathComponent(Constants.endpoint)
    
    let downloadOperation = NetworkRequestOperation(url: url)
    let parseOperation = ParseUserInfoOperation()
    
    super.init(downloadOperation: downloadOperation, parseOperation: parseOperation, handler: handler)
  }
}
