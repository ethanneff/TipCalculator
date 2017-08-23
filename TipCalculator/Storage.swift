//
//  models.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import Foundation

enum StorageKeys: String {
  case first
  case second
  case third
}

class Storage {
  static let shared = Storage()
  fileprivate init() {}
  
  let data = UserDefaults.standard
  
  func get(key: StorageKeys) -> String? {
    return data.object(forKey: key.rawValue) as? String
  }
  
  func set(key: StorageKeys, val: String) {
    data.set(val, forKey: key.rawValue)
  }
  
  func clear() {
    guard let bundle = Bundle.main.bundleIdentifier else { return }
    UserDefaults.standard.removePersistentDomain(forName: bundle)
  }
}
