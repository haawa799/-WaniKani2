//
//  WaniModelConvertable.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation

protocol WaniModelConvertable {
  associatedtype WaniType
  associatedtype PersistantType

  init(model: WaniType)
  var waniModelStruct: WaniType { get }
}

protocol PersistanceModelInstantiatible {
  associatedtype PersistantType
  init(realmObject: PersistantType)
}
