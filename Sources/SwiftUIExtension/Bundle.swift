//
//  File.swift
//  
//
//  Created by Teakowa Yang on 2024/4/16.
//

import Foundation

extension Bundle {
  var displayName: String {
    object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    ?? "Could not determine the application name"
  }
  var appBuild: String {
    object(forInfoDictionaryKey: "CFBundleVersion") as? String
    ?? "Could not determine the application build number"
  }
  var appVersion: String {
    object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    ?? "Could not determine the application version"
  }
  func decode<T: Decodable>(
    _ type: T.Type,
    from file: String,
    dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
  ) -> T {
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Error: Failed to locate \(file) in bundle.")
    }
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Error: Failed to load \(file) from bundle.")
    }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStategy
    decoder.keyDecodingStrategy = keyDecodingStrategy
    guard let loaded = try? decoder.decode(T.self, from: data) else {
      fatalError("Error: Failed to decode \(file) from bundle.")
    }
    return loaded
  }
}
