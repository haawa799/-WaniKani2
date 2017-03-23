//
//  WaniEndpoint+Promises.swift
//  WaniKani
//
//  Created by Andriy K. on 3/23/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise

internal extension WaniEndpoint {

  /// This method creates a combined promise with downloading data from endpoint and parsing the json into the 'WaniParsedData'
  var promiseWithFetchAndParse: Promise<WaniParsedData> {
    return PromiseBuilder.newFetchPromise(url: url).then { (data, _) -> Promise<Data> in
      // Networking promise
      return Promise(value: data)
      }.then { (data) -> Promise<WaniParsedData> in
        // Parse promise
        return PromiseBuilder.newParsePromise(data: data)
    }
  }
}
