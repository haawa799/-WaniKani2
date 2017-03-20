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

public enum ProviderPromiseError: Error {
  case transformWasNotOverrided
  case selfWasRemovedFromMemory
  case castError
}

public class ProviderPromise <T> {

  public static func providerPromise(endpoint: WaniEndpoints) -> Promise<T> {
    return endpoint.promiseWithFetchAndParse.then({ (parsedData) -> Promise<T> in
      let value = try endpoint.dataTransformer(data: parsedData)
      guard let castedValue = value as? T else { throw ProviderPromiseError.castError }
      return Promise(value: castedValue)
    })
  }
}
