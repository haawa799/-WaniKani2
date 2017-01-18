//
//  UserScript.swift
//  
//
//  Created by Andriy K. on 9/9/15.
//
//

import UIKit

struct UserScript {
  
  fileprivate(set) var name: String
  
  init(filename: String, scriptName: String) {
    name = scriptName
    if let path = Bundle.main.path(forResource: filename, ofType: "js"), let js = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
      script = js
    } else {
      assertionFailure("Failed loading script with name: \(filename)")
    }
  }
  
  mutating func modifyScript(_ modifier: ((String) -> (String))) {
    script = modifier(script)
  }
  
  fileprivate(set) var script: String = ""
  
}
