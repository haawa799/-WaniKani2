//
//  WaniPromises.swift
//  WaniKani
//
//  Created by Andriy K. on 3/17/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import Promise

internal struct PromiseBuilder {

  /// This method creates a Promise around the dataTask, for downloading endpoint
  internal static func newFetchPromise(url: URL) -> Promise<(Data, HTTPURLResponse)> {
    return Promise<(Data, HTTPURLResponse)>(work: { fulfill, reject in
      PromiseBuilder.dataTask(url: url, completionHandler: { data, response, error in
        if let error = error {
          reject(error)
        } else if let data = data, let response = response as? HTTPURLResponse {
          fulfill((data, response))
        } else {
          fatalError("Something has gone horribly wrong.")
        }
      }).resume()
    })
  }

  /// This method creates a parsing Promise
  internal static func newParsePromise(data: Data) -> Promise<(WaniParsedData)> {
    return Promise<(WaniParsedData)>(work: { fulfill, reject in
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      guard let root = json as? [String : Any] else {
        reject(ParsingError.noRoot)
        return
      }
      try fulfill(WaniParsedData(root: root))
    })
  }

  /// Helper function for URLSession setup
  private static func dataTask(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    let request = URLRequest(url: url)
    return session.dataTask(with: request, completionHandler: completionHandler)
  }
}
