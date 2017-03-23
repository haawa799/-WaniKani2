//
//  WaniEndpoint+Promises.swift
//  WaniKani
//
//  Created by Andriy K. on 3/23/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise

public extension WaniEndpoints {

  public var promiseWithFetchAndParse: Promise<WaniParsedData> {
    return WaniPromises.newFetchPromise(url: url).then { (data, _) -> Promise<Data> in
      // Networking promise
      return Promise(value: data)
      }.then { (data) -> Promise<WaniParsedData> in
        // Parse promise
        return WaniPromises.newParsePromise(data: data)
    }
  }
}
