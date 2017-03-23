//
//  GroupPromise.swift
//  WaniKani
//
//  Created by Andriy K. on 3/20/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise
import WaniModel

internal class ProviderPromise <T> {

  internal static func providerPromise(endpoint: WaniEndpoint) -> Promise<T> {
    return endpoint.promiseWithFetchAndParse.then({ (parsedData) -> Promise<T> in
      let value = try endpoint.dataTransformer(data: parsedData)
      guard let castedValue = value as? T else { throw WaniKitError.typeCastError }
      return Promise(value: castedValue)
    })
  }
}
