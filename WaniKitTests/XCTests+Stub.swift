//
//  XCTests+Stub.swift
//  WaniKani
//
//  Created by Andriy K. on 3/23/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import XCTest
import OHHTTPStubs

struct Stub {
  let responseJsonFileName: String
  let urlIdentifier: String
  init(string: String) {
    self.responseJsonFileName = "\(string).json"
    self.urlIdentifier = string
  }
}

extension XCTestCase {

  func stubJson(_ string: String) {
    let requestStub = Stub(string: string)
    stub(condition: { (request) -> Bool in
      return request.url?.absoluteString.contains(requestStub.urlIdentifier) ?? false
    }) { (_) -> OHHTTPStubsResponse in
      let stubPath = OHPathForFile(requestStub.responseJsonFileName, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }

  func removeAllStubs() {
    OHHTTPStubs.removeAllStubs()
  }

}
